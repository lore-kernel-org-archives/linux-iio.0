Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16FB3A960A
	for <linux-iio@vger.kernel.org>; Wed,  3 Jun 2026 14:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780495733; cv=none; b=gS1n3bR/ccdxGj2F7YBbgFmVuZad5Uzt78wqYCvIfTzgLt+xjhK0Aj6YNnA84id9V7dOHX7d+6TVfbAeDj1lVbe5X2dW6o1ZCCxWOqlgFPH/9aH4nWE7BrvtJmGdpUhIHjiuAp9iymtROE/05g7a0xUymrtKh4x0u72IUoHTaAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780495733; c=relaxed/simple;
	bh=L3ZPpwbHa76nNAHfgBqExbWbe/NkLxokXKDlmicbUV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVLPDZmNFAEmEo/eBs7nPM31xx+oPLkofXMw8HGltEVyGpSf5Fi8fRpC0w+t1TbGreR7hoze31X+d9Egom78+3HEPrSUjLYFbdGQcmwwjkzAbw1GYNk+Ky6jn5yWIMEwH1psqiQ4xXT2VvzMzCQPbJ6FloXURLJr2EnytKR/huA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxAMb7SY; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxAMb7SY"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bed4f2f0898so503160866b.3
        for <linux-iio@vger.kernel.org>; Wed, 03 Jun 2026 07:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780495731; x=1781100531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3ZPpwbHa76nNAHfgBqExbWbe/NkLxokXKDlmicbUV4=;
        b=IxAMb7SYZTKP/P44MdIGxBfOc6GgCL8dvL8PiAv1ayGA0vV7W6Njqq9851tgfqXi+R
         24GdM/b5h7J5H5OF/vRV8QNA0FngMsvpTNpqzpvpVdqsByBy2E/V+NzovVU6z/l2Lyij
         JgcBU5OG/D8sPI1u1DAQO1Rm1hPDo2Ihfu91dIGQ/LjgFZEFXuqxng+fUsWMK+BGymHn
         WoPAnSqljl12pqmtvu4x1x2gtsPmG+9WFFxR6G33Ieyf56GswZKjF0RU/HVKUmzoJVOH
         eX2vWV7f3nglDjaKM/iX8zEskjTLR9kzKMz7kQAsUg35JNtqtRFarP/adyuWqZZ4tkpR
         EXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780495731; x=1781100531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L3ZPpwbHa76nNAHfgBqExbWbe/NkLxokXKDlmicbUV4=;
        b=n9LztG3yk437jokh9Xgz9FRpy91m5sw9nPIOQ0Fj20wckifpIChO8oQb4aMsw6RNBY
         esF4TdoN0AJJmBTogvqmy1wTIabNpzWU6SYl3fGZ+DkWuWiFvCGSe/gWi1W0G/V48BaG
         5lQZpKs+rNyI1i2JSkRG4nnPT4VWAEWL9LVFAm4dg0/UbphhNj2lc3K2onj/uTr1SrQb
         oC7vn5j7yWfrnweHUwqIkT4JUo18wArRCQC8Vp4lK5ytIAmtk1w2VHLgAM4Cdz2s+L+3
         zNkfOx4i7UaoUVp5I1ixE/IJdebdfWl9Sneh4sDF50tykzPCuiVbWYrk/PlH+KLII5J3
         oBUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9FqsoNSoOdrxngrE1RXtsCxk/XZ1NStTzZ4RKDhR1aN/Ae/J4VfvXFcrREl9dhqgcxIW9T495/H2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwablsMWLurAKTXmPg1lQ8B/IJYAPhbsF2Uu9TyjuYWzkdOx1MR
	L5Reyl1ZkwOuPoFERzXwvP8F25MdIAB78YpfkvSf8lOWlE9dTGqMgZMv
X-Gm-Gg: Acq92OF8203O7NDNrIp9vuO6m/jLMBL9Mk4QVA/qsUP4Je6KQCLOkmlW/33hkRN66G9
	NpJYsK3I7sXMELoM4aM9SUkufGtmc0xbywR0aoUFeM6sQRIMSPc8VUmqMCd9iPVNwifFQwmoweH
	W6JA+oTjPWPA5LcmSmx9GYgjzwiNyXxWp0pODFBzvSTcPKqETLsO36n3GGxg89X+bNy1f1n/7e9
	ZpOMmKzRIqpclkjaRwNEo4z87ZdRjPZ1KeSVOMXhPhr4Neigyg0nZzBRIY1DyakjObneOs9fT85
	fbB+Hsn/2I8XDAjzRQ6Wp7xGJmVXUd4/j0sXP218KhPPDg/lqwC1VH/rScQHYsOBFtyp+ro2tBV
	OyLnCdeBhzT4rgvFWmTe6bxaCKUKE+coIOEm/cBWciF3X29xhrwxQ8ROb91UF9JaXF/u4wI5V9j
	dIvGe/JmtZuiWGji1Yg2Y9hdz79I1IpDTQQMfOpxZFgWUE/ms0/HpXmnR4OJ6mOX36+29YcZTBC
	FJDl9I=
X-Received: by 2002:a17:907:c10:b0:bd9:2b46:99b0 with SMTP id a640c23a62f3a-bf0b4395c05mr203050166b.49.1780495730961;
        Wed, 03 Jun 2026 07:08:50 -0700 (PDT)
Received: from fedora.embedded.cmblu.dev (p5df027fc.dip0.t-ipconnect.de. [93.240.39.252])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf0559f1ac0sm162062866b.62.2026.06.03.07.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 07:08:50 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: flow: add Sensirion SLF3S liquid flow sensor driver
Date: Wed,  3 Jun 2026 16:08:34 +0200
Message-ID: <20260602-slf3s-v3-reply-06-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <ahzWI-bQwnQ8ogFL@debian-BULLSEYE-live-builder-AMD64>
References: <20260530205435.37326-1-wafgo01@gmail.com> <20260530205435.37326-4-wafgo01@gmail.com> <ahzWI-bQwnQ8ogFL@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 31 May 2026 21:45:23 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Can buf be 6 bytes long? 2 bytes of flow data + 1 CRC + 2 bytes of temp
> + 1 CRC.

Yes. The third word (Byte 7-9 in the datasheet, Table 8) is the signaling
flags: 2 byte flags + 1 CRC. The driver does not use the flags, and the
datasheet says the read can be aborted with a NACK/STOP after the temp
word. So i make buf 6 bytes and read only flow + temp.

Wadim
