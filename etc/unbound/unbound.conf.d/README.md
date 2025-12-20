# GPG

```bash
# decrypt
gpg --decrypt 99-local-3x3cut0r.de.conf.gpg > 99-local-3x3cut0r.de.conf

# encrypt
gpg --encrypt \
    --recipient DFB3790DC3F40E81ADA049557E776A00EBA1F80A \
    --output 99-local-3x3cut0r.de.conf.gpg \
    99-local-3x3cut0r.de.conf
```
