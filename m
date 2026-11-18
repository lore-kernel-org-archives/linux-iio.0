Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795006502;
	b=Yf3q8YOI9Q+yaEr63fXzfXh2BgoxmLQx+b5zP0BjnKkJQLpdj0j1EjQCXfzCzJz/q0g2
	 Y/lmDrz5Y1mrvrjldhAcJgyhPCsgY3ZFeQ2fdKHCvxgw4zCYSNzcJjLqH1gq54cCNJbfR
	 MWTlkBJU2HavHydL5yUdBc6jrWED/hT6jrZ83dChQv2FAduXv4XOJIM4IK9uvE/5OnaFj
	 qicCetvac6bfNUKYoYb0zy2hSQpBCx/I1VSp2K3p+5QPU+AegcIZl9if2U8UH6pkod8I8
	 hJgsCXFrqKbijWEnQtGARKYVArf7Qifw3NlPlze1xGhtDq3feNzvVj3mUEpJEDh6Ulw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795006502;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IfM0L8l0KO0jyxCjtdYXdfOsa3a+oLhBOi1/EZWw89g=;
	b=FGRI1k7LgjN7h6Dfqyzh7s/V7lx1p5NK13k4ba0lwqjfqzVhp/ok4KVBxJ/mtak9FZR2
	 aJvD+m7wRAKcHKgl8YOEvH6hjLU1beublD46of4zplRS02KJBxlgdgJTYssDV6l8eiuSx
	 +hVOuxKIgxzgmmBAHcAm70ZUjDfiL+hVlcpefH+bfCUSU9J7xhT6GaqKoQ6srJhH2qfyW
	 P8JFQjxCj6EQYKGOmKa0whD1aNGNuUQs/w15EBzwUluxjp/Czye4BhEJWGL3Bm0wrYPWW
	 v81BtayfML9MMyWKKrBNJ+ouL/lm3d/sJRKayFtme5XZbiCwXRRLkA14BVk4Sn7xJvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EphXuosv;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74072606A31C
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 12:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74072606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EphXuosv
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8b67f25e6e1so570150b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 04:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795006502; x=1795611302; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IfM0L8l0KO0jyxCjtdYXdfOsa3a+oLhBOi1/EZWw89g=;
        b=EphXuosvpZhHwI6IoqC6D3LFGaENEM7sy1ZRdj1dyjNvm/QjfgRYFiVIyZDyoJbans
         FRFPiwS3AhE0rk+194XgBKD9NkHDmBdHYWEgsBdjvga8q8Ct+cNz82NXuvLyOtxPSNIJ
         ubK48OlxNXIPGW5oMX34QX+tkLFND0cFhvJcGTyGf+NfaiaNNghgtmGjEEIvZ9RKWSm9
         b6PraheLd02vraVWfG0AeqgW6NJfgBaXvNWTsTEghEHLUIRi3mLXlBE3H8dltr4f7FXT
         ZMoUyJFl2W1TZ38XlUiXSZLai/CUSZMWGOyZfgmWRpp5Hny09i+czp77OG+jp2/0xJhS
         /MLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795006502; x=1795611302;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IfM0L8l0KO0jyxCjtdYXdfOsa3a+oLhBOi1/EZWw89g=;
        b=nPy7C+1UJQvHjKYt3y6ZW5eG8nlDBo5tDrG/wbXymO1kckg20NM5lgGHZ0NKw+CmZG
         Np1Jewl0XagNYvoAHSci10l/Nf9UMh2RC2X98CSUJcbO3UO8o5oTLhoqcLx4SRvSa6FI
         pjkcP+ORoM1cHgsF8h6zf1DYrJ9nu05tNLfqeNLkPsroG/cBbrOkMGkauU3Krf0DqMLP
         SnPZ9eqnzv39IhhoN4YC0na/0WMJUCh7Ddg0YNqdl8+XqhuyGxuw5W8DCwk4AL9/y9NK
         dtMj/IQRyWfk4Olf8cQrgjHomCeGLQLBpoU5fMVnBN3baIgnP/ZQgOHgBc7riW4Heq4j
         W5sA==
X-Forwarded-Encrypted: i=1; AL+hErFGGsgLWWgo2K5KAcQEaoT0biYhFsZWPszwD0dzpza2Mid08FvzyAEyTQZ5WPuIqtj3pdZFuqAvN9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Zb//bDXtfYu/U+VNyMtkyP4djcG8Ccn7uIPGCPWUBDdcys39l
	FVzHrLuEWzsVhNjRniDHYge1F8v/mnoZBkayNegvyO339fvDU0NA59Ph
X-Gm-Gg: AYBFou2zqYUCdOVHshA+krC85q6hOAZQnJ7ayNdBdb/QUtH6rvd2d59X9aHZBK8As+6
	jB6ZeZPl4MfiBNrWIlBRudRaA4yZ7De/QGRGNvC8PZ4SKkKcxKdvYL/QSQ5IGjt/EjRDjzIC1m/
	ndzNA/DTicVcMEhCFv3KKUU1eDzvB13mcN1j2ihphx/XEg1xZ9Xv5ZHVdXFTriGCmZ8xWS/ksRI
	jWjWUPMCSSp6cu+C24vE+d9p7yp5BcIZzHrCbpb0ltTaqNwHmWUjeRRoMBt829MZSli9i6ENl2I
	0H3qzx60Aeo4NTRdJa0tpWDfdKZ36G8ZtIPBkd6I4oifGU7omKYQjGmadgKln0kePpsP33vW60D
	TSEE8qKIKSNkL+G7YIVgZ3iX9xUki7IL/3r2SKlChNacYXHkXHoOtk5xuehqt58PaeBi5qDjK6d
	sPMakVvqDUsl36c/n5f8OTjfEd/fzcQnqsL/OHLKTdJ+lQTC8nSbn/z4/jaFFeEmtjSD/9oAEPa
	/7gsj0F9jAJnFL0v/4DkyvC1IKHtDc+XhJdxPqpsnXOuHdo77pPszYPmdrr+MGtlJTxbfaF1KVI
	8D0Tro09sOEqBKiQ/PE+bxCydg+VuTW7yJSA166xR3YzZzyP0cA6QCjvJS4qCAzN4NHIEzegXfx
	tMXvEup6p4daOZsZfAQKPCIZ32Iei4IU9o4GJCM87PLwbUgumE+SCf4qL8uahkY4qp6fjmD+UvV
	6KdDDgh4958npoYhfhikDlzAm/vzV2wuhsbKbxPFuH+KzLTp1Bz58=
X-Received: by 2002:a05:6a00:1d86:b0:8c0:7517:b9de with SMTP id d2e1a72fcca58-8c5d3e116f1mr2084551b3a.32.1795006501788;
        Wed, 18 Nov 2026 04:55:01 -0800 (PST)
Received: from kapoor ([2401:4900:e034:2676:5ea6:3ff3:ed45:7b44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5c7f99a7fsm1199883b3a.1.2026.11.18.04.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:55:01 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Daniel Campello <campello@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Semtech SX9xxx: add a reviewer entry and binding maintainer
Date: Wed, 18 Nov 2026 18:24:49 +0530
Message-ID: <20261118125450.12512-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <bbdef966-c5dc-4101-9246-b668e00f62b7@kernel.org>
References: <20261117172612.25535-1-kapoorarnav43@gmail.com> <bbdef966-c5dc-4101-9246-b668e00f62b7@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Nov 18, 2026 at 01:34:31PM +0100, Krzysztof Kozlowski wrote:
> I think it is premature. You just started contributing and your early
> submissions were clearly showing that you did not read kernel docs
> before posting.

Hi Krzysztof,

In June I was still figuring out git send-email, and a problem with my
setup caused those repeated postings. It is also why I was not able to
reply to you at the time. I have since worked through the process
documentation and my setup.

Since then I have been working steadily on this subsystem, and 23 of
my commits are now in maintainer trees. I still make mistakes as I
learn: not grouping patches into a series, writing commit messages that
are too long, and sending new versions too early, as Andy pointed out
here. Changing MAINTAINERS is new to me as well, so there are mistakes
in this series too. I take those as part of the learning process.

I asked for this entry because I have become interested in these
drivers and want to keep working on them, and Jonathan agreed to an R:
entry. I understand your concern. If there is something specific you
would like to see before this entry is acceptable, please tell me and
I will work on it.

I will not send another version until you and Jonathan have had time
to comment.

Thanks,
Arnav
