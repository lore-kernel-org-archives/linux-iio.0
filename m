Return-Path: <ana.calinov@gmail.com>
Date: Wed, 8 Jul 2015 07:04:31 -0700
From: Ana Calinov <ana.calinov@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, michael.hennerich@analog.com,
	knaack.h@gm.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: frequency: adf4350: Delete blank line
Message-ID: <20150708140431.GA20967@spook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This patch removes an unnecessary blank line
found by checkpatch.pl --strict:
Blank lines aren't necessary after an open brace '{'.

Signed-off-by: Ana Calinov <ana.calinov@gmail.com>
---
 drivers/iio/frequency/adf4350.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4350.c
index 10a0dfc..9890c81 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -72,7 +72,6 @@ static int adf4350_sync_config(struct adf4350_state *st)
 	for (i = ADF4350_REG5; i >= ADF4350_REG0; i--) {
 		if ((st->regs_hw[i] != st->regs[i]) ||
 			((i == ADF4350_REG0) && doublebuf)) {
-
 			switch (i) {
 			case ADF4350_REG1:
 			case ADF4350_REG4:
-- 
2.1.0
