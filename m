Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <gregkh@linuxfoundation.org>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] iio: adf4350: fix compiler warning [-Wuninitialized]
Date: Tue, 5 Jun 2012 11:52:18 +0200
Message-ID: <1338889939-28705-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

drivers/iio/frequency/adf4350.c:316:32: warning: =E2=80=98val=E2=80=99 ma=
y be used uninitialized in this function
[-Wuninitialized]

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iio/frequency/adf4350.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4=
350.c
index fd4c850..2d09f82 100644
--- a/drivers/iio/frequency/adf4350.c
+++ b/drivers/iio/frequency/adf4350.c
@@ -310,6 +310,8 @@ static ssize_t adf4350_read(struct iio_dev *indio_dev=
,
 	case ADF4350_PWRDOWN:
 		val =3D !!(st->regs[ADF4350_REG2] & ADF4350_REG2_POWER_DOWN_EN);
 		break;
+	default:
+		ret =3D -ENODEV;
 	}
 	mutex_unlock(&indio_dev->mlock);
=20
--=20
1.7.0.4
