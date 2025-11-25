# GPG

```bash
# decrypt
gpg --decrypt post-up.sh.gpg > post-up.sh
gpg --decrypt post-down.sh.gpg > post-down.sh

# encrypt
gpg --encrypt \
    --recipient DFB3790DC3F40E81ADA049557E776A00EBA1F80A \
    --output post-up.sh.gpg \
    post-up.sh

gpg --encrypt \
    --recipient DFB3790DC3F40E81ADA049557E776A00EBA1F80A \
    --output post-down.sh.gpg \
    post-down.sh
```
