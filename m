Received: from mail-oi2-f42.google.com (mail-oi2-f42.google.com [74.125.231.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971722F5495
	for <linux-iio@vger.kernel.org>; Tue, 29 Sep 2026 01:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644902; cv=none; b=Q2j1X/+m2nePndvzbIpBSR2xgxIK1aGyLTSuX8IsK4xlgWmMegwYxkojNU6PbNvlwbgZ0xQ4MLal3uqgFHYG6w0ryCpjJ/VqodxfHN3GXnRx1D+tEkF+TAt2f1tbBVtO5MdOX6eHOL36qzrLS6yDVKJAiSjbS+oGXyjAq5I7/3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644902; c=relaxed/simple;
	bh=n0NF20FVc7dFuhkFp5r7/ym4uGaeOxlFX1AIR7oub6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Auamu7NZF7hphCZ2ew6Ntt2XDhVhEIGzqqGsclkkPR6PmQV7pCdB5CfUPuCBwYRr5NmoFnz7RUm/gGNhOQe5cbIb4OtWAe8eP0+tV3Z9StRvBD2tDLMj1Rj9qAPPUkPVEg7AXfR1fJWuco+SklQ27S3wffjc2M9TFOJv60DzOeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3/vhqrA; arc=none smtp.client-ip=74.125.231.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3/vhqrA"
Received: by mail-oi2-f42.google.com with SMTP id 5614622812f47-4e874624e83so521432b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 18:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790644899; x=1791249699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EdlWV1UrrswI4TlOFB+Lu4Lt2sreQh/UqmTFUVR9kI0=;
        b=M3/vhqrAC67vr9DJocBiCDDOLHEd1dL5VFv24euU6SzbUQgHu9Hm7maiSoOTskWh63
         rZWQxsASTEzqO3k4BvaPgF2Xh84s7H+TEogi8ngp5zHFIWKRThk1v+JpRo684akO/ylU
         X77lL45SKVMjGibP9BE7y4CWcP8EuACrgLLoaM3PD3nscYWNbN8JkOP2T4Jis5bE70gj
         sd87GW6TJBop8vyf5s4wyiAOhlKp1UBFfeS8oQtuCOw/hR//cIlq8QFZJKhxXfi0CS5j
         WwPytA2b/PdzH3MYweW4JNnU1Z0U+h8+kuUx6STHFB1adQXRN1jCL43LO97zeSY7XxQF
         uIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644899; x=1791249699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EdlWV1UrrswI4TlOFB+Lu4Lt2sreQh/UqmTFUVR9kI0=;
        b=YNxZhrNYK2bdkOgx55PvYoeO5dxfIQjNNV2FE8wJ6IqXw7tH9kdSEWhDttI8srmHo7
         fD1viDGuDUUp5dm0VjzUUsBX4Od+LtG4XhKtWEl2saOm8wh8RYfa6Hrt4Dp5SyDqZWCV
         rCLDs1SKstousVMk8r9zK5uMbwlsg6jfhhRqz6V4wyNVMR63hOR17bVmakx6DJ4to/Ie
         o5DxlsK8iuw+ySilXHfGAKFSWWklEQEzAayOFdDY4hJqnOKlPeQ3nLHQodU847bi/oMk
         kXRhtq1vNDFbikERas2/Eae+0T1aWm/fTzVQ7BD4I2gArshg6TH3vnz58u/LaDkW001z
         qKgA==
X-Forwarded-Encrypted: i=1; AKwUvBxxUqbjrdKLNIk93J2cikwvS3R+trqiGRigpNxmmGDp8OmBJ7T1ygqJHSNxsoV9G/qYAmFBGAN6iww=@vger.kernel.org
X-Gm-Message-State: AFuF++kEEvLydoO4Rvc/BtZnnj2AUXEV0MidrTiho+HmOOLNy+GVbJiy
	gGGMdpE6LHjuUMTJRHxTGisVye1Mz5oXgLHRIAi07+/+R5swVRHktTh8
X-Gm-Gg: AYBFou2h4mp0dcE67CwOXsI/Cy9mNVnObEdSvLUpxoTyuEsbE2ioEBxxuzFeBFAffK6
	vWEbsJSQ6ummkMzmuS1VI7w5f/YdbijikqdrgKh8nP+GqdfKgK+Y6JclD8TIUa0JGhZVbem9T1+
	/ohtn0jO1qUjxKz5Vwx6GT3UHJgSrHiSLSnq+QD5J1ntO/ZFWUEzk+BMwdDE7KVV2PqdlCCSE+S
	yaK1cghSyyG5aAIzJ6Kmxr48x5q1AXhRv93Vyv+7+r71bTwt2n7yByfAffsHoCFzXfs35rg/Gul
	nbT0og3IslaitPrEQKh7bPr/fuS6a2ENyZD0ruxNmntIjPcvqSUT3WAr7pfnEkzFLYz6E6BHajT
	HSjfOb0mz1Ooji2V31CxgyBK5WXaQDTJHArxbiTgemrWLIaExezE3HqbZz+5M0udFmZFHgice7/
	lxVIHgBw7T9TwomelCwnqpxc28HRnJAKMJ/WzEdcZEuVZrQGTRkRqSjDFGfkEEfzxPigziUfpZj
	QVYbGDC/wNRpRAYT7JDh4MURXdCy5zWTfGFCysB9DX3IizHDCk=
X-Received: by 2002:a05:6808:c18f:b0:4d6:9133:cff3 with SMTP id 5614622812f47-4edd64228bamr679952b6e.26.1790644899389;
        Mon, 28 Sep 2026 18:21:39 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ebbc7b9453sm3546338b6e.13.2026.09.28.18.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:21:38 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] counter: Allow 32-bit tasks to use the character device
Date: Mon, 28 Sep 2026 20:21:38 -0500
Message-ID: <20260929012138.71156-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

counter_fops has no .compat_ioctl, so COUNTER_ADD_WATCH_IOCTL,
COUNTER_ENABLE_EVENTS_IOCTL and COUNTER_DISABLE_EVENTS_IOCTL fail with
-ENOTTY for 32-bit tasks on a 64-bit kernel, e.g. armhf userspace on
arm64. Without a watch, such a task gets no events from /dev/counterN.

struct counter_watch has the same layout for 32-bit and 64-bit tasks,
and the other two ioctls take no argument, so compat_ptr_ioctl() is
enough. struct counter_event, which read() returns, has the same layout
too.

Fixes: b6c50affda59 ("counter: Add character device interface")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested on x86_64 in QEMU (counter-fixes plus this patch, KASAN and
    lockdep) with interrupt-cnt on a gpio-sim line, toggling the line five
    times per run:
    
    - before: tools/counter/counter_watch_events built with -m32 fails with
      "Error adding watches[0]: Inappropriate ioctl for device", and so do
      the enable and disable ioctls; the 64-bit build gets all five events
    - after: the -m32 build gets the same five events and the same errors
      for an invalid watch and a bad pointer as the 64-bit build
    
    No splats. W=1 builds are clean for arm64 (COMPAT=y, LLVM=1) and for
    i386 (no COMPAT).

 drivers/counter/counter-chrdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index 61451ba74ca1..f5bf8e40096b 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -457,6 +457,7 @@ static const struct file_operations counter_fops = {
 	.read = counter_chrdev_read,
 	.poll = counter_chrdev_poll,
 	.unlocked_ioctl = counter_chrdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.open = counter_chrdev_open,
 	.release = counter_chrdev_release,
 };

base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
-- 
2.55.0

