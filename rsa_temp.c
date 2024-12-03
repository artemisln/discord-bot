#include <stdio.h>
#include <stdlib.h>

int is_prime(int n);
int gcd(int a, int b);
int are_coprime(int a, int b);
int totient_function(int n);
int encrypt(int m, int e, int N);
int decrypt(int c, int d, int N);
int power(int base, int exp);

int main(int argc, char * argv[]){
    if (argc!=6){
        printf("Usage: ./rsa enc|dec <exp_exp> <priv_exp> <prime1> <prime2>");
        return 1;
    }
    if((argv[1][0]!='e' && argv[1][1]!='n' && argv[1][2]!='c')&&(argv[1][0]!='d' && argv[1][1]!='e' && argv[1][2]!='c')){
        printf("First argument must be 'enc' or 'dec'\n");
        return 1;
    }
    char * user_choice = argv[1];
    int e = atoi(argv[2]);
    int d = atoi(argv[3]);
    int p = atoi(argv[4]);
    int q = atoi(argv[5]);
    int N = p*q;
    if(e<=0||d<=0||p<=0||q<=0){
        printf("Negative numbers are not allowed\n");
        return 1;
    }
    if(are_coprime(e, totient_function(N))!=1){
        printf("e is not coprime with phi(N)\n");
        return 1;
    }
    if(is_prime(p)==0 || is_prime(q)==0){
        printf("p and q must be prime\n");
        return 1;
    }
    if(e*d%totient_function(N)!=1){
        printf("e * d mod phi(N) is not 1\n");
        return 1;
    }
    printf("Give message :\n");
    float m;
    scanf("%f", &m);
    if(m>=N){
        printf("Message is larger than N\n");
        return 1;
    }
    if(m<=0){
        printf("Negative numbers are not allowed\n");
        return 1;
    }
    if(argv[1][0]=='e'){
        int res = encrypt(m, e, N);
        printf("Encryption is %d\n", res);
    } else {
        int res = decrypt(p, q, N);
        printf("Decryption is %d\n", res);
    }
    return 0;
}

int power(int base, int exp){
    if(exp < 0)
    return -1;
    int result = 1;
    while (exp){
        if (exp & 1)
            result *= base;
        exp >>= 1;
        base *= base;
    }
    return result;
}

int encrypt(int m, int e, int N){
    return power(m, e)%N;
}

int decrypt(int c, int d, int N){
    return power(c, d)%N;
}

int is_prime(int n){
    for(int i=2; i<n; i++){
        if(n%i==0){
            return 0;
        }
    }
    return 1;
}

int gcd(int a, int b){
    if(a%b==0){
        return b;
    } else {
        return gcd(b, a%b);
    }
}

int are_coprime(int a, int b){
    if(gcd(a, b)==1){
        return 1;
    }
    return 0;
}

int totient_function(int n){
    // επιστρέφει το πλήθος των φυσικών αριθμών που
    // είναι μικρότεροι του n και comprime με το n
    int res = 0;
    for(int i=0; i<n; i++){
        if(are_coprime(i, n)==1){
            res++;
        }
    }
    return res;
}
