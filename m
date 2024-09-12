Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0A0524D7;
	Thu, 12 Sep 2024 03:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726111734; cv=none; b=TnUz3g6MUD0OtqngsxbfpMHlV/Bux7O09zCYic7QcdV5//aMz1NkXTkxgMlFzULGT3UJlpCpWHKaMILLTp4CI128LYqo3e+aoAuKJ7P5d4l6qxV/v5H95jxQ9q16hg6LAY8UoXAU8I4PWqKYIjRMxGhEyxPO+L3e2x4vLaGtO+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726111734; c=relaxed/simple;
	bh=aaHump5Ez603AvINyLLmEIe2gGnCkcovisCUNr6gNsk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=C30YakEJ/Oo9DfW9LeuM9+aoW0ITxT5SFgHHWnxIdlg43omEWq4o8He+ELE7T2S84Gn8kGLx5X+0wK0w4Bbi9+d5buB+ogQXiEHK0ipQ6QEnAFTGs0obHH+pLOti7Zbj8uWGNGEIVqSWuat5hU6TzuLpYAlYqyJMgqivylzozHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee766e25ff06ae-246b4;
	Thu, 12 Sep 2024 11:28:48 +0800 (CST)
X-RM-TRANSID:2ee766e25ff06ae-246b4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee166e25fef23f-fcf06;
	Thu, 12 Sep 2024 11:28:48 +0800 (CST)
X-RM-TRANSID:2ee166e25fef23f-fcf06
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: [RESEND] tools/iio: Add memory allocation failure check for trigger_name
Date: Wed, 11 Sep 2024 20:28:46 -0700
Message-Id: <20240912032846.2914-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

Added a check to handle memory allocation failure for `trigger_name`
and return `-ENOMEM`.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/iio/iio_generic_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 0d0a7a19d6f9..9ef5ee087eda 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -498,6 +498,10 @@ int main(int argc, char **argv)
 			return -ENOMEM;
 		}
 		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
+		if (!trigger_name) {
+			ret = -ENOMEM;
+			goto error;
+		}
 		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
 		free(trig_dev_name);
 		if (ret < 0) {
-- 
2.17.1



