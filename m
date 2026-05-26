Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986C33CC33C
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782075; cv=none; b=oZCiMr8qu8PE2J32OtP/TPlKaOWJ65KzbJsKjJ1p4oxW1R5qttKtkdcxRGKzzymL2qSjuCfgBOOohEPnxcsRl1UG4xMeKBGk1cjzaP+ksv85KQ3V+W8szuhT1bP0g5LgSRTMQBY+mW3hehJ6Cw1RTfLdWlh7sco8ZAgLxR3WidQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782075; c=relaxed/simple;
	bh=ZCzYZSYmq0Bdj0y074Ob27I4KDxi/Eu124thntVFzFE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DPYTDbfPnkJX2aBFQWzIr6oAf8BCIFUESkUr8EnEVM2//yJzg0WSlQyA0nIbOXM/fgIBV5byFAUrPCl9TB8Wg4HkZhxxVF82k4/o4lnaUOcSoCMG/a6SbEw5I9EfadJsQDZffLzJ+eAjqiR0IQ5OaD+1RRsKJxCmNwFMWnwqIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=id8qJID2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="id8qJID2"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43fe608cb92so6209753f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779782072; x=1780386872; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B7jb6Q2svElITGdYdz0b8hlR0PUrc3RqPX6M6n0CsxQ=;
        b=id8qJID2AdOitBbps9okz0eNXUwQwBB0l4CNlV0Z2r/rte/lD3IBiCbdr0I7h7iRp1
         eXhI6RnfoHXmRMXacv1eSGOttA2btsyolFJnbFGjf/u0W1VHkEIchAiavGGb5OG2I/1I
         Tb6tr5I2ySJCJcbLg5ovi1q9/o+w3wGCYxfGEqGfbntFM36UdlFyL9VvP2iIjnHDNWU8
         CmNKjsJwWJ5VvmhUz0GEsD2YaBwwBzFc0qMzTMHX69AZx9ztbCLj2N0GHu+97fW38+TC
         oIaipmUBXiEp2Ju9CTL62C7Cyi70wNg4idh0WDQipX0UgYxcd1m8WmiaZxMj50DpNftW
         ZkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782072; x=1780386872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7jb6Q2svElITGdYdz0b8hlR0PUrc3RqPX6M6n0CsxQ=;
        b=AbJWLiWNDBELL765mv7A9//vikSpT97A8NDjnc71sUZy7QH3mdWseqMqf8sD/wE7Mt
         9C9lPYz6urWQixv7+CAMZCyRst7me5OxEWWGU3XOxyij5KJSb+7sevV8A80zawKTI1yd
         AuguwyPfiqW3MCAuD6uLdaOY/qUyXURiCjoATtzytCvsxWJwvCOkmtLRdo7MFJybK5yK
         o0qwqT01AbOgkLvugf72FmhC1x8HJFEPQiYL1TIfSqGfMuWQhFT6YNnS97kJ8290mRui
         YruCW9/rqKZzl5bcAOnq1xyax7Q8WfPbEPKDwHj7fazqtoB0tbpzrmFExBtNyGVvrTYe
         Br0A==
X-Gm-Message-State: AOJu0YxBDROegiyxSQOftkYkh1INGT1OQZMFCSEKLXnHRiRm9JIO1JWD
	LFysw+P9ZTZB2wBh51HI1GbJuNI8XRgByIRVdkFtxl1if8XQWqPz608KytV0H9Lk
X-Gm-Gg: Acq92OHDJG7u/JXwxoaLCZPPbAF/6KaELliekDlkSvojLUiEThJa/MX0x/xXVHx+pUR
	+5n9CPQvdN6DAjR1rBTenS1202SBVD/aglRDsISfMh382vFO8dTzN+39fQCxcWUbdHyl2GLthIy
	gX1Huelud4JMvx68SUFlJqDoOklZDWoCzu6f5mINPTqQ8/Zhs8yfV/v6PVQFnctDZY0KQWJdZPA
	gi8BJMbVnbk4FV37QLa5sW8ZGUIRnOQySc1bzHqlIt4EvN8XoCFQRdz4I2TTjydr0Rorbyb6BQm
	nBcIJaWGKcl7WViIdXnWrXE7kbBydTUh7JKU8nvI51rj76TFN62ROv7UzmTPiMYnWCpDnzB0bzR
	1nYf3W5mzAcaHGKA2OzVp2JKGNksvHg68X0rrvBFA482BxFoKAjkuQtIiWbd5xWfmmpRpOzPLhb
	xE5WrHka790knzyTKEYl9jFmdZ1SOIL0TQ5sZdlxmjAH5VS8TeqOB0b2dKVW75VqLv235RrBam3
	qzFLc3TZPs=
X-Received: by 2002:a05:600c:4688:b0:48f:e230:80a3 with SMTP id 5b1f17b1804b1-49042ae99afmr283891315e9.33.1779782071782;
        Tue, 26 May 2026 00:54:31 -0700 (PDT)
Received: from gmail.com (108.red-79-148-246.staticip.rima-tde.net. [79.148.246.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ea134sm339835725e9.8.2026.05.26.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:54:31 -0700 (PDT)
Date: Tue, 26 May 2026 09:54:29 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [PATCH v4 0/2] iio: light: add support for Broadcom APDS9999
Message-ID: <cover.1779781224.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add IIO driver and DT binding for the Broadcom APDS9999 ambient light
and proximity sensor. The green channel uses optical coating technology
to approximate the human eye spectral response for ALS/lux measurements.
IIO_INTENSITY channels are also provided for red, green, blue, and IR
so userspace can compute its own weighted lux.

v4:
  - Renamed vled-supply to vcsel-supply (matches VVCSEL pin name)
  - Expanded Kconfig description (ALS, RGB, proximity)
  - Clarified mutex lock comment
  - Replaced magic number in scale formula with
    54ULL * NSEC_PER_SEC * USEC_PER_MSEC
  - Updated TODO to just proximity (color channels now exposed)

v3:
  - Dropped RFC
  - Fixed MAINTAINERS entry alphabetical order (B section)
  - Changed IIO_MOD_LIGHT_CLEAR to IIO_MOD_LIGHT_IR
  - Unified RAW read path via chan->address for all channels
  - Switched enum gains/rates to #define (hardware field values)
  - Used USEC_PER_MSEC for integration time table
  - Removed redundant comments from resolution enum
  - Added default rationale comment in _init()
  - Added ALS rationale comment on IIO_LIGHT channel
  - s/reg/regval/, fixed indent in poll loop, C99 .name for id table
  - Moved iio_info right after read_raw function
  - DT binding: expanded VCSEL acronym, explained separate binding
  - Commit messages wrapped at 75 chars, clarified RGB vs raw status

v2:
  - Added IIO_INTENSITY channels for R, G, B, clear
  - Switched to guard(mutex)(), devm_mutex_init(), dev_err_probe()
  - Replaced remove() with devm_add_action_or_reset()
  - Don't fail probe on PART_ID mismatch (fallback compatibles)
  - Replaced manual shifts with FIELD_PREP() / GENMASK
  - Used get_unaligned_le24(), sizeof(buf), NSEC_PER_SEC, fsleep()
  - Named gain register values, explicit resolution enum values
  - Removed section comments, grouped bit defines under registers
  - Squashed Kconfig/Makefile into driver patch
  - Split MAINTAINERS entry across patches
  - DT binding: added vled-supply, interrupts, required vdd-supply
  - DT binding: fixed title, added blank lines, full description
  - Dropped "DT binding" duplication from binding commit subject

Link to v3: https://lore.kernel.org/linux-iio/cover.1779181370.git.azpijr@gmail.com/
Link to v2: https://lore.kernel.org/linux-iio/cover.1778659152.git.azpijr@gmail.com/
Link to v1: https://lore.kernel.org/linux-iio/cover.1778491503.git.azpijr@gmail.com/

Jose A. Perez de Azpillaga (2):
  dt-bindings: iio: light: add Broadcom APDS9999
  iio: light: add support for APDS9999 sensor

 .../bindings/iio/light/brcm,apds9999.yaml     |  54 +++
 MAINTAINERS                                   |   7 +
 drivers/iio/light/Kconfig                     |  14 +
 drivers/iio/light/Makefile                    |   1 +
 drivers/iio/light/apds9999.c                  | 337 ++++++++++++++++++
 5 files changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
 create mode 100644 drivers/iio/light/apds9999.c

