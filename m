Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058519;
	b=KKg8YNj0DZezdmNQAU4kyU00wA3hf1qnbm+Hh5Oj4jAyrj2RR01bj743Mer/FeF/wLfz
	 +PeDqa/3ZzjxTCaUnp1bN/VeAAOJlmjuufNnH/WhEM9CUVQvoMsJ//mF8QAetmYE36nC0
	 N2RGABzt6Hs7tI7rfKzRcHAd88fa4I7ul8k7+fJgWGX+8A0aEQOVmsVazG4r6GVhLjcY5
	 OFmSk1iWCHIMjGr0B2f017NpkDP1QkmQOknNymsnuwEWz6unMgkcVOjMixhhLLw06z4iV
	 7YIdcywrPDeQOkumtkPH9/UGUx1LPnrxjCnSKMvEo8tvgMlboCpBDjtrFBRKIf9U5Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058519;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hhXowr4rVyN186VIrBLYbctwIo84/+XDG/s2yvvwBfQ=;
	b=NGSi2rPTFiTwcohZeyScmKf77mA1Qvv1ald6J4UrS5C+rTHo/oHzR0EGS9zo57cLrRSF
	 C4NuFQUyOfz57DwQp6FwD8czancx1lg0/Vd9YcSWoRrStVemTbCy1oQtJnoZ3+4iblm77
	 m3/xReNK0HzP/VAyBe+dOwTYU58jmG4JaP8n1N4xbibDJDJKFIcZS+gjznHAQ3JmW4E0g
	 PvKXrsGH0DRcv0+Lu3EW69fgvOKyrlt4PPSPfKaWvXkISzKPXeTemrBGG4BxAu5On+F5Q
	 mgaaHzLQUsvl/AbQZuBk0YGQv47aGjzDk3wutG7/WWmSmPyJK9k3uRLE6QrO+874yvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=umwRNmr6;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90ABF606A33E;
	Thu, 19 Nov 2026 03:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90ABF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=umwRNmr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=umwRNmr6umuD7QRks1fj7cs+EXsJORMLFMzhze4O/5L/B+aekfJKB4Wm0TBZg6zqPqkLS6UF8RhLn
	 RTZw3heFo8DzsrL2bCs7nDUYjp1/iVswiEa30BnbRRm7ILOtrv5nW3xQZHjMHrXtmkp7gRe+RsUm7d
	 8t+Npmc/RX9AdyRE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16afe6b53593-f50ab;
	Thu, 19 Nov 2026 11:21:57 +0800 (CST)
X-RM-TRANSID:2ee16afe6b53593-f50ab
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from devin-VMware-Virtual-Platform (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36afe6b52ad0-06bf2;
	Thu, 19 Nov 2026 11:21:56 +0800 (CST)
X-RM-TRANSID:2ee36afe6b52ad0-06bf2
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: andriy.shevchenko@intel.com
Cc: jic23@kernel.org,
	andy.shevchenko@gmail.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhujun2@cmss.chinamobile.com
Subject: Re: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration write errors
Date: Thu, 19 Nov 2026 11:21:55 +0800
Message-ID: <20261119032155.11434-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <avrStKkcvUApPMDb@ashevche-desk.local>
References: <avrStKkcvUApPMDb@ashevche-desk.local>
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

On Mon, Nov 16, 2026, Andy Shevchenko wrote:
> How is HW being recovered from the inconsistent state(s)?

Hi Andy,

v3 has no hardware recovery step. The LOCK bit only controls write
access to TIACN and REFCN (datasheet section 7.6.2). Setting it again
leaves the register values as they are.

If the unlock write fails, we stop before writing either configuration
register. The resulting lock state is unconfirmed. If a configuration
write fails, the chip may be partly configured. We try to restore write
protection and return the configuration error. If both configuration
writes succeed and the relock write fails, we return the relock error.
In that case the configuration writes succeeded, but write protection
is unconfirmed. If both a configuration write and the relock fail, v3
only reports the configuration error.

In all three cases probe exits before registering the IIO device. If
the device is probed again and I2C is working, the same sequence writes
LOCK=0, rewrites both registers and writes LOCK=1. That would restore
these register settings regardless of the previous lock state. The
driver does not schedule a retry or reset the chip after these errors,
and I have not verified recovery on hardware.

Datasheet: https://www.ti.com/lit/ds/symlink/lmp91000.pdf

Thanks,
Zhu Jun


