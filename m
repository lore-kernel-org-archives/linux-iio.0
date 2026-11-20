Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795155551;
	b=2aVrnzVmsq5izGH6h+rkxEsiC9bJ8V9vn2FHCZhZq1N3VaF8Svi3/Vlocu9DvSbjWClW
	 fx+O7WV7SBJhYDSwPnmqvfkxT2FZGAXlXvU6uAwmakYUDrH12kRmijfQJN4a8iPFZqiJ6
	 CQUiLalqYjKqtWTZXmw7g/cCp9vuNPc+KosGmc/ojHv4T+bujDsppHsO34pfWrkagRpbW
	 4Jr747LB6AKtmhH9N4C/wncHEoWnYkyyD77xYIDhIJPZwEBb0nXmsy/7wqLbnwxFlPDQL
	 kteHQZDdTiCD5HaZm4Y3yETtLmZDXzXiEx89hFgQuzEBiVYBSFobRpau+m3NtEYMOhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795155551;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oKPLq7uuL4FriEgm+iR7fJpIAnOpwk8KT+SLNP73Hps=;
	b=ddnNE8eQYKso3rvHv3HrpW89FROA/Hn2WyZppCZwH7tgAOeHF8Zo5OKGy3WFDeo8S+8b
	 45N7R5ZPwupqXs3b5O7DDNcQ+6uK4ITcyyFMP4juTYZEBMgftYS5LowOLq7ZukEOoofNT
	 laJlkRT8FOXjdfV0JnUuukluFs7Zj9ul3fe3OlmLMq0U6ljKz9YtX3wkcl88x/AtCH6Pa
	 u5hdS3BZXgRb1UxVJoWsrBVVsTxlobVXp7gIkVjbI2s/1+2AkRmb9+t97h97tWKnnpo7x
	 BJMrnGaZN0aaFIFfFDulBZZ4l4yj02bp0UKFGwfMqGBketHz0fCcey21ApErQlCJzjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=I9M8PZrM;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B7A606A338;
	Fri, 20 Nov 2026 06:19:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23B7A606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=I9M8PZrM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=I9M8PZrMLA0TffLoabszwNZWiYSayOtrdri2VnHgKM39XtzzKxVz+sVqvqW/SJaJjyT0rB3TB7Kh3
	 MPUmbxveXjnnPga+3xX84+ljcaONU4EIe2lrIAmQ0Oq0pEZCZa7rJO14+2/iKuUrdwbdh8wXY7Md+x
	 Nl8vUje3T8nHx+B4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96affe658b2f-2a56d;
	Fri, 20 Nov 2026 14:19:05 +0800 (CST)
X-RM-TRANSID:2ee96affe658b2f-2a56d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform.localdomain (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee86affe65716e-80c93;
	Fri, 20 Nov 2026 14:19:04 +0800 (CST)
X-RM-TRANSID:2ee86affe65716e-80c93
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools: iio: Keep the buffer index separate from the acquired fd
Date: Fri, 20 Nov 2026 14:19:03 +0800
Message-ID: <20261120061903.98141-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIO_BUFFER_GET_FD_IOCTL takes the buffer index as input and replaces
it with a file descriptor on success. On failure, cleanup can mistake
the unchanged index for an open fd and close a different file. Only
assign the returned descriptor to buf_fd after successful acquisition.

Fixes: 8827faab2c8b ("tools: iio: convert iio_generic_buffer to use new IIO buffer API")
Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/iio/iio_generic_buffer.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 000193612aad..fd955cf444ad 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -404,7 +404,7 @@ int main(int argc, char **argv)
 	int ret, c;
 	struct stat st;
 	int fd = -1;
-	int buf_fd = -1;
+	int buf_fd = -1, requested_fd;
 
 	int num_channels = 0;
 	char *trigger_name = NULL, *device_name = NULL;
@@ -714,11 +714,11 @@ int main(int argc, char **argv)
 	}
 
 	/* specify for which buffer index we want an FD */
-	buf_fd = buffer_idx;
+	requested_fd = buffer_idx;
 
-	ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &buf_fd);
-	if (ret == -1 || buf_fd == -1) {
-		ret = -errno;
+	ret = ioctl(fd, IIO_BUFFER_GET_FD_IOCTL, &requested_fd);
+	if (ret < 0 || requested_fd < 0) {
+		ret = ret < 0 ? -errno : -EIO;
 		if (ret == -ENODEV || ret == -EINVAL)
 			fprintf(stderr,
 				"Device does not have this many buffers\n");
@@ -728,6 +728,8 @@ int main(int argc, char **argv)
 		goto error;
 	}
 
+	buf_fd = requested_fd;
+
 	/* Setup ring buffer parameters */
 	ret = write_sysfs_int("length", buf_dir_name, buf_len);
 	if (ret < 0)


