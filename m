Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63AF365A19
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785420292; cv=none; b=j2TYB4SgJKIRg7YNRpV+jfq+dNggsBX7QK54OjQ1/EbQ4uDSKZbyiPikVinEGZUk1VCz6yHNZ6ShBUj2R33L2FZT7XyaGxHQNB3Nu4qRfQzHrCbZD4OEbdlG8xKtx3MC6Wv1ULh8vFPbg1jN2bPgpbXLuwWZJvoGxPBUmfHNiy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785420292; c=relaxed/simple;
	bh=jgTYfMghKJuDXopxsuXRLfK+0JXaCK4/EdwPpRa9efY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EyrUm2BHvEw1M1J+/1atwexn3uuPlR/jZJbqqVRQna4W6yq6wVt+CSiGGn2uaPnN+IjZHr0fHfTjZCXPQHhZPw4GXXsziigOj1jHq8SNICGT8lTvb0JdK9V3UMpPIHsx0xrqeeCVwyZrzJOv+Qa/xQWprTP8d+e3b1yWyqSpu48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zt0MNu3A; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zt0MNu3A"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1513515a12.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 07:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785420291; x=1786025091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jgTYfMghKJuDXopxsuXRLfK+0JXaCK4/EdwPpRa9efY=;
        b=Zt0MNu3A3L1erUO4L+XVA5a/UqKx+2+td61iTJKwCukH5SHHqFFTDPGDp1CA+MLB1A
         8ZvGhk2+NnhkOMTeMFsPCccdTOYTvPuYPbucISoxpxmH6Qz6eMZNbbeJ2KzeVyvaTX42
         rwYvuGbUXppZLxC4AX71c0TJe8MdH4og5O9ScmVQM655nd5u000yx2CWUwNmuJC3pMy6
         jFsv0qsGSQipLTShRxfQW/kr3OqwgatkdssGkznUmwkxx/xEXNqKpIV+pHc3fFKa1qdC
         fhJTVEeVbNc9lWh2H228SgZin1mRulb12JTnztjO/CChwEgU093o0YqwhnSAtqgFXC/W
         0N4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785420291; x=1786025091;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jgTYfMghKJuDXopxsuXRLfK+0JXaCK4/EdwPpRa9efY=;
        b=kPIGJWmdoP7Ra5DXPrfpQkHIoZOGO7JMMn039dfUy8ZuMy83JghNFzD/H1Tvcs9aI/
         zka6IBjOStIaIbE59KliVibj0CjbbB8tvtEtGzwDWgZE0QoWAqfaBdexoXXbYRjB79ZU
         9viQrCBmconhmkqxagYKJ5DBMYIdaxQ3uF+4LaNnQV/rgW8erCBZLlr7YVuklFXOBdGI
         pcyyYAsP7VMXinQNbt0fasVmaiazLsCS7YQ4LvHwDlR73HkDlPfhAl9/U8n9IzgNCjZE
         mHYxFhW5ozPVSYiWTHMoMrknQtVxL8NfEkj3VN7LF2vgoopUgcQUorechrT3BtT4amvF
         uU+g==
X-Forwarded-Encrypted: i=1; AHgh+RpK6/YQflmecFI9ZyCHN4czN8PmTBoYPSgQaIol8USFbDB0LdPz/KPZCMCGRkJIgvtTG3zi5vxYcb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzqvvOttaU8RfAq6lUZi99o6oZ6rTp3h/ZiXExgiRkSlvnJdWT
	NLNa/iUzDvxIaUtkwvoSeW3kP7g9OSylmPcqOoyHpdFasVQPF7TyxDTJUS6KuhF8kixovg==
X-Gm-Gg: AR+sD11DnlYcA7iLCqhTq7bZ98sRIwgjXb8s6Ghf11yJbps/VU4DHL1jAjma4iLja7e
	1fCjdBuuB921d/lsE41euQsGlA8NkIRiokvNto45x38FF+YKG3NeBISrxDwAJvufDP8UQRLEMw2
	1RIy1DeMiIzL7hTWP7SBGWXi67c+bhaC/55Cv1KUt11eG/gtC+DwB6a4i6CZNn0GTFWJT3wnwHQ
	CkNwmxGkh5q2bBG1S8vMMBGI50OE0V5J8c24rFSZor7cJ+4q3umO/3BFX47KpmGk4CBR93cDmga
	KlPbIpBnsqf7kV9cKye0II8uVXbgi7xWolkzJz7uj5cvffjE45AcxqByO5cpLnL1qL7pFXNBYbk
	P+/Coa+d7n5YUZ8vDDKqB+ngEHkVQ1T4QRy3Z/lbLF1y0I6HYxYe84JD5Q0g1fG/OTYKbAYk9g7
	Bq4S96PcBXucR+GYjrSLFzdpQmhTrdZgBdTerUZIN2EKNaCLeOaE7NGOxBTa4=
X-Received: by 2002:a17:90b:2590:b0:38f:474f:e77 with SMTP id 98e67ed59e1d1-38f9c0655d1mr2406707a91.37.1785420291101;
        Thu, 30 Jul 2026 07:04:51 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5fd6:849a:c1fd:20ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b15f77sm23551069eec.4.2026.07.30.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 07:04:50 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Subject: 
Date: Thu, 30 Jul 2026 19:32:44 +0530
Message-ID: <20260730140405.369634-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727034009.5c6b0be9@jic23-huawei>
References: <20260727034009.5c6b0be9@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Thanks for the review.

This v2 updates all applicable probe-time error paths to use
dev_err_probe() and removes the redundant error message after
iproc_adc_enable(), addressing your feedback.

Thanks,
Mohammad Shahid

