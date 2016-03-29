Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:63587 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029AbcC2U2T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Mar 2016 16:28:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: st_magn: always define ST_MAGN_TRIGGER_SET_STATE
Date: Tue, 29 Mar 2016 22:27:27 +0200
Message-Id: <1459283273-1059478-1-git-send-email-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When CONFIG_IIO_TRIGGER is enabled but CONFIG_IIO_BUFFER is
not, we get a build error in the st_magn driver:

drivers/iio/magnetometer/st_magn_core.c:573:23: error: 'ST_MAGN_TRIGGER_SET_STATE' undeclared here (not in a function)
  .set_trigger_state = ST_MAGN_TRIGGER_SET_STATE,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~

Apparently, this ST_MAGN_TRIGGER_SET_STATE macro was meant to
be set to NULL when the definition is not available because
st_magn_buffer.c is not compiled, but the alternative definition
was not included in the original patch. This adds it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 74f5683f35fe ("iio: st_magn: Add irq trigger handling")
---
 drivers/iio/magnetometer/st_magn.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/st_magn.h b/drivers/iio/magnetometer/st_magn.h
index 06a4d9c35581..9daca4681922 100644
--- a/drivers/iio/magnetometer/st_magn.h
+++ b/drivers/iio/magnetometer/st_magn.h
@@ -44,6 +44,7 @@ static inline int st_magn_allocate_ring(struct iio_dev *indio_dev)
 static inline void st_magn_deallocate_ring(struct iio_dev *indio_dev)
 {
 }
+#define ST_MAGN_TRIGGER_SET_STATE NULL
 #endif /* CONFIG_IIO_BUFFER */
 
 #endif /* ST_MAGN_H */
-- 
2.7.0

