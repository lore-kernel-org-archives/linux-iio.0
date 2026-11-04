Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783660;
	b=uySZe1E2QNK1j7ub1LrG5Zk5MQxmZuXFL9PR/Y9/LfTjstuBzx2n4gx8dTzhuCVzhcTa
	 KxUz5wvTSTaiIMJU+gSVI5urdmllmRp9DKUZTyH6LcHka9YMELv9AMwY2e1brg+KipuvS
	 NLGziq+/NUaTAtt0fB4mh66ddAeMv0XFa751vjRzSMz5a7r9iE53uM7G36SySTCIPiM8f
	 9RdsRfVKztv0s+lVQmmOEyK91OZvhULvv/WpcHjhS3OcgSzdBbqxfKZ56CI4yZ4PAvMTz
	 Olej0gA92H/d/LKlKArMXJxEDk9yYZgH2sv96j1brWLe/mqemZhUvYl3gBk1Db55jPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fUFqV6LYPfFbvIJN3vCkCa0VcPqluohoUOdtjNFtJFU=;
	b=Rl+TmnePkUG8WQYP0oyd/awXqBCFofSjVYShpgvrAI9UUVMlc6T1e7BoHW/Ff+yRyPwj
	 a8xWUk+XqJNNH+o0erW0gNaDg859UVWHqN5DBDiHZZK3cVHHm1XDybXKQvyoYttcFJ7zj
	 yEHiwzjfBG3+5+1KGiFQ8534qFRm/PP3sE6VayeAVeWdZGFE1EbGK8YgG3hsNulG2C3wU
	 RfQIS/vogi3Z+QbxHeb4+okg9IrRlHJEIcDS6ZCL7ROhvjLDr1gyu9tqucGa6j6K0aLLx
	 Y3mv0hXarI4t9S5MXoduCEEEw3yJpM0OjLw3/AXwNTxl5nTCTv2R3L0VDDZw4Vb22xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2Bstzp6;
	arc=none smtp.remote-ip=209.85.208.170
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C67606A328
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 09:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97C67606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2Bstzp6
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ac97e45a79so3891971fa.3
        for <linux-iio@vger.kernel.org>; Wed, 04 Nov 2026 01:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793783659; x=1794388459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fUFqV6LYPfFbvIJN3vCkCa0VcPqluohoUOdtjNFtJFU=;
        b=C2Bstzp6u6hLZsPCrlYakCTaaHkbhXuN/8cDmKJej09VOuEqBeIm1xUFqH4gNaAgzv
         Jo1RPQc66hhXCbJTA2DyITYIDKmQeXF9/AIS970s4TlAP7EE8ZP2kAM5QwVJOkJKFllm
         D5YhDda5xCiJB9KHI8fh3UAngwBWLMuGNZe9demt7gNsK5UV2l2KMM+9wWFD4IktDTfH
         TSLxlw9J9qpOZT4y9p7uMbn1rTt5Jbdft04CWr0U2Rt0OOODK8gtU8FQqj5mup0uk7qw
         ws98yncChm5Ajj5E3RNuIz3HqoinZpiKSnzkzrcntpkGC0iQiLliTzNPUARcPZTLT0dy
         w1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793783659; x=1794388459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fUFqV6LYPfFbvIJN3vCkCa0VcPqluohoUOdtjNFtJFU=;
        b=LkTepwQbzuwO91BLAKBz79VhiVr2eK3mGfdZ4qhvG6t6LQ3yyZZMMRkVjH0MB4SE6H
         i1PXH4NN96jNRMZUH7ovhyKywjS5j2p5lXP7JXBv3ftqZ0Yfct5fmxzdh5+N6TnJMHXO
         AfQTln3d5KXRnFfbd+OOq1MHnGEd7XY1KAuwLcLxTxbn4YQm4vLkvFcwzcSqX3meSMFV
         /Y7SUrccWx+AVNNYgBZ0LnJTj7bSn2E6ZKky8AhllXx/6DAfd8Cdse8Cw1fyaOSShyW1
         1CtgeVoflRE1cP4UCfJaKyrYTT8fyDanMhWOpoQ62X9aql+6mm3/Fp1oQ3opY2Hc11Qj
         N7Wg==
X-Forwarded-Encrypted: i=1; AKwUvBza1L3O3D5hoWSFhfwWlvjcuyvzJmtN5Z+2VZz/Zbew7/EGS5gd62Hy3TwZ5EvWT7t4p2Y8LPkVIC0=@vger.kernel.org
X-Gm-Message-State: APuU4Z85+bG1BoLN2RBrG+akLl0bvx87KjxyQuw2Zr9bOiPBSKOq1vb8
	495m3mDlBNgNU88+wxtXu/j41ypBT2TBFGe+CYLg+saP3VXpU3RwEA7n
X-Gm-Gg: AYBFou0g34LeBfzlufpNjHQRRYk/+SFjn244h6HpmIXgYbseozoDuOiMm1ICGi3lN6i
	/KSv3y9TNLxTSk0FDAdADfqdSKX6FA3BuxEjIVZIX+RXtpYRFp0LqtUZx0asPeJe6vyAAVN74MZ
	SlhZTGZRKWFsqhYmgAPoe9MX4hysWFWNdK/RbGprma+t+ZYHESN3FssgvWnJFBYOTebPGAIqzN/
	gReL8oTrhLaKATl8inIHTgqn/qQd2hc3GlWB4lgZjNDDVj4Rlj2f4B2qWvqSehTDbbbScTLaAu1
	w1jxgKG3lLUDFKVhr56E0olmxItYmbRGFJV4HQ7cqDCXXJq9Kb+qAlIrkDXqw1/Kna5zeP7VFNv
	i77myBHQc5BGmlK+NbC5waEVF6soLnq9hAqPFd5LkabKwDPgjQQPUIm+lf4WWmjTEZvSANkd98W
	/Hg5rEEfPMK9Qs3NFK5Tnicr8oLLePwR1aaZed5xNaYBP94m4MMZL+uGyUDDwqobFFMnCiNs+Kp
	kTwaubfgs+zh3G1RLnj8QT6Lc14nFPOm47ZvAdxwsG8euq0xK88+V227slk5ijJMFedOfUXt1nw
	Iv9qf6AfY1DFoBoAdJmnh1clMZlVDe2JFuPwjUH4gZm1/IAsy5KzfgkpqKFxQj158iLYlo6xjIK
	Ejp2pNK5yjc6/h1kbCdeiRfcnBww7AfoSYiaaspK5STC99tpVygBIX+G9kw==
X-Received: by 2002:a2e:a991:0:b0:3ac:48a0:e253 with SMTP id 38308e7fff4ca-3acb7b46ed2mr37352601fa.23.1793783658695;
        Wed, 04 Nov 2026 01:14:18 -0800 (PST)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acdc6bed64sm3253031fa.7.2026.11.04.01.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:14:18 -0800 (PST)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: dps310: put the chip in standby on remove
Date: Wed,  4 Nov 2026 11:14:15 +0200
Message-ID: <20261104091415.710751-1-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072755.17043-1-zoone.rupert@gmail.com>
References: <20261102072755.17043-1-zoone.rupert@gmail.com>
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

On Mon, Nov 02, 2026, Rupesh Majhi wrote:
> Remove resets the chip, though all it needs is to stop background
> measurement. Write 0 to MEAS_CTRL instead.

On a ZTS8032, unbind leaves MEAS_CTRL at 0 with the configuration
intact, and 20 unbind/bind cycles read fine.

Tested-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>

Paulius
