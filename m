Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/5] staging:iio: core: add datasheet_name to chan_spec
Date: Sun, 27 Nov 2011 13:13:58 +0000
Message-Id: <1322399642-22924-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1322399642-22924-1-git-send-email-jic23@kernel.org>
References: <1322399642-22924-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

This allows for matching against the name given
on a datasheet, however silly/inconsistent it might
be.

Useful for in kernel interfaces.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index c225542..11c2f25 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -110,6 +110,10 @@ enum iio_endian {
  * @extend_name:	Allows labeling of channel attributes with an
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
+ * @datasheet_name:	A name used in in kernel mapping of channels. It should
+ *			corrspond to the first name that the channel is referred
+ *			to by in the datasheet (e.g. IND), or the nearest
+ *			possible compound name (e.g. IND-INC).
  * @processed_val:	Flag to specify the data access attribute should be
  *			*_input rather than *_raw.
  * @modified:		Does a modifier apply to this channel. What these are
@@ -138,6 +142,7 @@ struct iio_chan_spec {
 	long			info_mask;
 	long			event_mask;
 	char			*extend_name;
+	const char		*datasheet_name;
 	unsigned		processed_val:1;
 	unsigned		modified:1;
 	unsigned		indexed:1;
-- 
1.7.7.3
