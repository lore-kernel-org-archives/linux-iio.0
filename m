Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6AA61FCE
	for <linux-iio@vger.kernel.org>; Sun,  6 Sep 2026 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788692721; cv=none; b=us8WwBjyAjxKS8npWBPi9goU6UuWaM4hK3bz40umBII/Fs/IbslI2WfkomC353jUT2aTVzoTPwkX2p1AE5zqhrerLMC17nevT1Nz4c3C5sizeyiWNC3kf7YuJQSOAVuKJJdreYanqiCpaZTqL7wqRR3eHlJG6h5eGLwsxE6CKQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788692721; c=relaxed/simple;
	bh=tvdFzmKtwoFDJ+q1pM6DGnbGu6Ko8qfu6YNLpfpo3h8=;
	h=Message-ID:MIME-Version:From:To:Cc:Date:Subject:Content-Type; b=Kh/5g/U7Xk35hcio1HujtK/vBEHAyfSfUEdznedQHl2MqLvBrSh9Dd+1e5plpSh/jQNQ5eNpMY5wscm8ec2/m9cvFT4Ui0/2eXAUzVol7++7L4S+Q7RIXnv84PV50Q33r0FdJwt447KI/eaNmKv3YzcVkg2z68nYtFTBkd57R/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnHm9ciW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnHm9ciW"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db3305f94fso12508875ad.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Sep 2026 04:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788692719; x=1789297519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9gyLWtQLohjNP+UG4PRUGY7mDiKdRQaFAscLEnUlZM=;
        b=mnHm9ciW1jOamz5QsHS/6Og08nilUmO0rHjnvdKkkgm3xEEeCTF7li+fBn2Gv9eTnY
         w2dspwntaXSovpYdBP/1XopjGG0+kmrdhdLnrZPYisBCQRtEfED+DQztWeHaQcfZTbW4
         LVj98unjzia5W68ZJfcbn9plMy1bpcLa3vtnlN+1h1Yw/+XyDWx1xg3wnIV807gQJfgF
         WuCCOFoO6w4rbi8mBwHc4BAfAFrQRzuzatMYugUsc9nNCW5G5iVs7muayVKD6Q6CCAm2
         iCHerp5jGrr6zAk7qF90TqjRCoOTsVxXVrSsT5+e+T4SfCdKFes87U1LcJLntnouiQ1q
         9Bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788692719; x=1789297519;
        h=content-transfer-encoding:content-type:subject:date:cc:to:from
         :mime-version:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w9gyLWtQLohjNP+UG4PRUGY7mDiKdRQaFAscLEnUlZM=;
        b=jbaee/daTx6/i2bRwKGu9flrR05S17d+ZCnoh4IzEyyJ9OQuQNlJsHieufQVt65GN7
         Pf8soUtWdxY4O9ac2DBXGf4oSgrUe3IyEDs8P+hxvIy554+KZA70a9+kqgoxLs3mXedF
         RvvfJj9ofz/8rCTpJWPMf/Mv13XmdIfwDzN2k+kyBhY09gQFo4p6bOERLiXCOAS0cbhk
         QA/XdpIF9Wm2RiOZGdc1a8cOy1vGXPv9ChFrZepuNyE7GZo5x8s5UGPviFi4mXd5GDh9
         ASuYgDXeA9UREf2kDMxpEC17qziUOrrZM3kzwXfFrDufsHpa6HPQfvHW8KYp3h4RVM9g
         UVHw==
X-Gm-Message-State: AFuF++m/34LtDORfOoLy7/+Q7TL6Xe3c1lUz/ps3U26kO2ub9fbyiUv2
	NG+5xAm3cOueGJBXlTcfZVCDfCBWciLHxUKqXs9Ji+7SJDM+pHyj601L
X-Gm-Gg: AYBFou3IUDUxGS+57/tgVCqZBAaCGsdY/ne4wWjLIrdJ7u2Kx1LjwuYQj5rb+MmAA5x
	y8yLfhXjo8kmBwAE2Uot/ibf0xGIfLCiLkuAzcp3ItVo6tJl/m5mF71nMJCxxlpxUKYYc+kXNtG
	IUWAXVG9UCfj9TxtHKLT7Dw9d4zfkfIGWedPm5s92sGsXh7O9U5mH2ze4VUqA6V43LpU9kLQMo1
	c6KfgL6T2EIi21o267m74rQV6lEKLxuL5AyMYxumVfNmGPkieDmAlvSDCi7tnMoQ56LyjpT5lhD
	n/6YbanQNhi7IC+COzh4rqI5evJkg8KMctjd3w6tUCsSixGSvPIJtS0gNaYR+Ut4QULVteehClu
	tGiUfK57PM5PEy242JidF8BVf5wPcBl2x/GmN5dToBqH7K4WC3a3g5KEWoK0jcm14LRFew1Ng33
	AQU9Bjwm7HvlCsCu+vH8J3dZpvDgxKprWu054XGFrsiW0wRMVRSS+bnJiuItiA3fxQe47THIFl8
	PXy8znw39KffufuKT9X2H6y6ML+XlIiGXQRyADYTydw2x97bRBaobUb5w==
X-Received: by 2002:a17:90b:4b90:b0:38e:49c0:75a7 with SMTP id 98e67ed59e1d1-39b2610f2fbmr24009365a91.8.1788692719394;
        Sun, 06 Sep 2026 04:05:19 -0700 (PDT)
Received: from manush ([2406:7400:94:7a79:f149:be84:942d:9300])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432435648esm22779262c88.5.2026.09.06.04.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:05:19 -0700 (PDT)
Message-ID: <6a9d48ef.4987c784.3608f9.714a@mx.google.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Manush Prajwal" <manushprajwal555@gmail.com>
To: sai.krishna.potthuri@amd.com, conall.ogriofa@amd.com, jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Date: 6 Sep 2026 16:35:18 +0530
Subject: [PATCH] iio: adc: xilinx-ams: fix OOB read in ams_get_ext_chan()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The PL external-channel "reg" property is only checked against it=
s=0D=0Aupper bound (AMS_PL_MAX_EXT_CHANNEL + 30 =3D=3D 50), match=
ing the=0D=0A'maximum: 50' constraint in the devicetree binding=0D=0A=
(Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml),=
 but=0D=0Athe binding also documents 'minimum: 20' which the driv=
er never=0D=0Aenforces at runtime.=0D=0A=0D=0Aext_chan is compute=
d as 'reg + AMS_PL_MAX_FIXED_CHANNEL - 30' in=0D=0Aunsigned arith=
metic. For any reg < 20 (e.g. a hand-written or=0D=0Amalformed de=
vicetree overlay with reg =3D <0>), this underflows to a=0D=0Ahug=
e unsigned value, and the following=0D=0A=0D=0A	memcpy(chan, &ams=
_pl_channels[ext_chan], sizeof(*channels));=0D=0A=0D=0Areads far =
outside the 31-entry ams_pl_channels[] array.=0D=0A=0D=0AReject a=
ny reg value that would produce an out-of-range ext_chan=0D=0Abef=
ore it is used to index ams_pl_channels[], instead of relying onl=
y=0D=0Aon the upper-bound check.=0D=0A=0D=0ASigned-off-by: Manush=
 Prajwal <manushprajwal555@gmail.com>=0D=0A---=0D=0A drivers/iio/=
adc/xilinx-ams.c | 5 ++++-=0D=0A 1 file changed, 4 insertions(+),=
 1 deletion(-)=0D=0A=0D=0Adiff --git a/drivers/iio/adc/xilinx-ams=
.c b/drivers/iio/adc/xilinx-ams.c=0D=0Aindex 158e6133a..cd778d053=
 100644=0D=0A--- a/drivers/iio/adc/xilinx-ams.c=0D=0A+++ b/driver=
s/iio/adc/xilinx-ams.c=0D=0A@@ -1154,8 +1154,11 @@ static int ams=
_get_ext_chan(struct fwnode_handle *chan_node,=0D=0A 		if (ret ||=
 reg > AMS_PL_MAX_EXT_CHANNEL + 30)=0D=0A 			continue;=0D=0A =0D=0A=
-		chan =3D &channels[num_channels];=0D=0A 		ext_chan =3D reg + A=
MS_PL_MAX_FIXED_CHANNEL - 30;=0D=0A+		if (ext_chan >=3D ARRAY_SIZ=
E(ams_pl_channels))=0D=0A+			continue;=0D=0A+=0D=0A+		chan =3D &c=
hannels[num_channels];=0D=0A 		memcpy(chan, &ams_pl_channels[ext_=
chan], sizeof(*channels));=0D=0A =0D=0A 		if (fwnode_property_rea=
d_bool(child, "xlnx,bipolar"))=0D=0A-- =0D=0A2.46.2.windows.1=0D=0A

