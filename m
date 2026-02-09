Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78195236A73
	for <linux-iio@vger.kernel.org>; Mon,  9 Feb 2026 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770608383; cv=none; b=UxdskPS7TU+Ox5rqvBidd3mClTJ4XehJFKWKw/Al85HehnBoX1kcGaXZG6eraD8CuLid1KtrzkZkxW9fTdyfohJOKCcg0AMrFeuI5CovkWh4B+YQNqusfepTHORvxatF3yB+WGQIlgay3IuNpRBsZRG6lFomigWA84Uq7xFoEG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770608383; c=relaxed/simple;
	bh=mDWfQ5TQ7IKx3Jx2J+iH2KbYzclhCi7bvFUdjWsVD2Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=I6PvafcFJpVBw/MZr9SxCHmcMvlkDXsLUk8YuiLoSi6r+/tKZcQsIgiTV0jbA1UtccYH9+ZQ+yYT0QaG9f8OtextA75f2+oMdpEDCL9hHLyTvuM/xY/mRIM2tG/hk8hrZMtmID7PMyK68AY9xhwaMdC2+vTdiNnfX3KFuEZ9yQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq/+pCc8; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq/+pCc8"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2b8095668ebso347505eec.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Feb 2026 19:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770608382; x=1771213182; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gyuiG6Pl+KcjgV30EMZ/m11jRo1aHxOMp16zLwhY/U8=;
        b=Lq/+pCc8i12/lyVdX3xUL8dnSFEIEKwjiJsQJu0HnjJ7pwO1hhuYsLB57ue6UmaRPF
         vyTMBKTf8Fh8y6YXF2FYPaUrwhffpBA6TnTIMpi0Mo68ki1Zg2MqIrW/tVLzpju7Y2hV
         +wgD7YOE8xS6NfcTEv2Om38ldajjxC6M1Fi+Br0CchTHeo3g1AYHcHWPRzYlQWiWdivm
         f5f8n77O0dYSM9iwZY9mfcWV5RwWK0iGzV+VQ+Vhn/LWmH9LuxWlm621/rCGoRaoNr3e
         xvbtA54I5nZgCOTXwWJttGtYewL7xCKts0oB9/+r+tzTpq7G7GxYaksA8Y0mft/quYln
         sngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770608382; x=1771213182;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyuiG6Pl+KcjgV30EMZ/m11jRo1aHxOMp16zLwhY/U8=;
        b=Q5lUPZQR4EDotBZnMACYdeFAdnBFr/48m9AIugFkiVPj9PMhtUmR1pce7+V6wg4xfQ
         lBOon6CqKSGJIO36Xxvs+0D6dUvFOimolZrNbPMB7mOv7UBRxCPXv+rqtFb1L+/uo3aN
         pYTCsqM4GSBYV+djzsa2SJDVq7ZJ+ATYLwAuosO00TVthQfenwIkwM2BlXDh60f90w/b
         rAeILbMsMDNAfFjeBG5pz03EeEbkQAw9eiHlCsLWUXOhhm6eKD0lf0zXSbqUXElq4tKT
         KhblED9+trJntPv3phDIXK67RExx9gqgMkpVpauJTurG4NApmCS8xFqVAHi1NidvkoAd
         VSkA==
X-Gm-Message-State: AOJu0YwPELlb6TZbMkkpfffVggdwVe2wNLi0QautbMywVBQFbq7lTaYg
	spyBiMkQKU/Vq31bBNIiyDBqsqTpuaUYqs184P1eZSNG7/BIjYib4k87
X-Gm-Gg: AZuq6aIsf/nks+JqoBY7/bPe7QlumF0YWdfGHJKjyeZnbqSosAAOuz1oMhhUEIZWkTX
	NBnMy7p5ZSS8rJCQyDLXUSVsdtCrMV3deyCIh744WaFLjNQAT+iE5eQ6P3F95mIjV6+jkdNknn5
	J95Jt4AauYybXe6SmD0H7yz7iNqaJNUNjDmlqrTvi4SSSrbAxtQNjHcOqobEHUHji1fd3EpUHoG
	6YKYIf4E97486HnC31SMlYdq4GVOaUGY2zbfhgQNj8/wFB3/BlZUaCpbHAXsNFPpOZFgIxNH7cy
	S+G7fXUiM8/1IlbxOI/viQWaX4HQ2Nqih8AXtT5AkNUsCfI/xMMdyPRigl9ILwEUEIebpLBM/jc
	guh2DHGosgE7FE0bzNVwi8+q2bbAo7N2coOGfZdF0MTaiDm8I+q1o/ewEs3kiXcjXXTjBqrvD6o
	WD48wN3Bg5ezA=
X-Received: by 2002:a05:7301:3d12:b0:2b7:e929:856b with SMTP id 5a478bee46e88-2b8564e83d1mr2149490eec.5.1770608382489;
        Sun, 08 Feb 2026 19:39:42 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b855af5ca2sm7682073eec.8.2026.02.08.19.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 19:39:42 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Subject: [PATCH 0/5] iio: proximity: hx9023s: firmware property, safety
 fixes, and ACPI support
Date: Mon, 09 Feb 2026 11:37:01 +0800
Message-Id: <20260209-upstream-20260219-v1-0-2b4d74e309d1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF1WiWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIwNL3dKC4pKi1MRcXYiIoaVuonlimlmKZaKFaWKKElBfQVFqWmYF2Mz
 o2NpaAADk5V5jAAAA
X-Change-ID: 20260209-upstream-20260219-a7af6d9a85ad
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1540; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=mDWfQ5TQ7IKx3Jx2J+iH2KbYzclhCi7bvFUdjWsVD2Y=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJmdYW9qnu5U3pikNe1Szo9PV15dcQt6c2TSWk/LVBX5D
 7s/H15xuqOEhUGQg0FWTJHlzOs3rPmqD/cE/3bNgJnDygQyhIGLUwAmcomR4X/qUssz07Tu1h1c
 vcPui3hf1OK1a7TfHuhe98PspHRE762lDD9ul/Cpc23drTEl4EXXq38pvLv+fWL66W19lJvr9rE
 Zah0A
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

Hi,

This series contains a set of small fixes and improvements for the hx9023s
proximity sensor driver.

The changes include:

 - Fixing a potential out-of-bounds access when copying firmware data.
 - Avoiding a division-by-zero case when the sampling frequency is unspecified.
 - Allowing the firmware file name to be specified via firmware-name property,
   along with the corresponding DT binding update.
 - Adding ACPI device ID support to enable hx9023s on ACPI-based platforms.

All changes are independent but related to robustness and platform support,
and are grouped together for easier review.

Tested on a DT-based platform with firmware loading enabled.

Thanks for your time and review.

Best regards,
Yasin Lee

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
Yasin Lee (5):
      iio: proximity: hx9023s: fix out-of-bounds access when copying firmware
      iio: proximity: hx9023s: Protect against division by zero in set_samp_freq
      iio: proximity: hx9023s: support firmware-name property
      dt-bindings: iio: proximity: hx9023s: support firmware-name property
      iio: proximity: hx9023s: add ACPI support

 .../bindings/iio/proximity/tyhx,hx9023s.yaml       |  7 ++++++
 drivers/iio/proximity/hx9023s.c                    | 26 +++++++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)
---
base-commit: c8bfb63c902678228a0a265e22a5f55404988a43
change-id: 20260209-upstream-20260219-a7af6d9a85ad

Best regards,
-- 
Yasin Lee <yasin.lee.x@gmail.com>

