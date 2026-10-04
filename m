Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B423AFCFD
	for <linux-iio@vger.kernel.org>; Sun,  4 Oct 2026 10:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791110627; cv=none; b=iA8SDQwYkqCkdmxoVjObkSg7j30RMYd0RxcjcBKFGHGTLjEHjrB8+QqjrJMHASThDNMWaXlnSZQ8kwyqpTGYurDjlkfG73CjY5WyeX4ng0WEG5WbEFjzRrHaKGnSRX4S+xYM36bmCTBpENLj31KDyBXzoCKPc31DOkSPCfdtsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791110627; c=relaxed/simple;
	bh=hcocD3BnT8CdOqPzpyusgPL1v8JIiSzrfyMqca98N+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g1cRV6UsvvAZmJEZSXFbtknBiG3MAJijWT+ZMoekHM/udMyFfCYUQeD/sCU6mqCAWoXLL9/8mdj49rtxvcaY2NGRtoW31ZoyZcDRXtA3t5DIYrmm2SOX30F0hQDfrvOoAFprJJG2Quzb7Y4yED1cLngM9dq68p5spColjxORclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNcBohkK; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNcBohkK"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-15354aa70e8so1801180c88.1
        for <linux-iio@vger.kernel.org>; Sun, 04 Oct 2026 03:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791110626; x=1791715426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0woykvoAO5TomuuBQM4gQruWpQXJsME0/h5WzmLnGHw=;
        b=MNcBohkKNp6ylOq6iuUosYRR/dKC0Bq4Fd5MojzVrixqzPAEnDB4WoiObzwkeBpa0C
         RoSlCkEJV/XZ5XWVwadn+lasX5L7iQPHSEozAJoQGHATWI08mW9vJlphWJy3Txh1sm8M
         DMtd8IDMLHUi7QU53yQRKWvq5ZmOoL4RU3ZGPxYSasZMrlob85ib4LQItbCC23DLl8vW
         F18fRjzzV7YHKh2f/a9cBlsrTXHdKNSrGJa29SvDOeUfd5YA03Zp/WToktEwJT8t56g9
         plqRmpmyyESH25BNDpRNwOFu5nFT2IF2nVxYlEwqkR+vxxg2LtjahblmERWjqyacLE1R
         WOPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791110626; x=1791715426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0woykvoAO5TomuuBQM4gQruWpQXJsME0/h5WzmLnGHw=;
        b=Va/0Ms2bC8E3ihRsGL7AZ2cY2cQIwi5aFbyWsxwDvneSRQolZnkpSUk2e1tz+qWgnR
         QyWv8jTLLHflx10LRuvUTyllbjyI0PMHodF/22WhicCeTCBOMqzrGjpL3W+5OXZbAqZW
         xKfzjNRQwI4CLXswcLeK3aUF31gCJqEoX3MBMJ03gRColavH6Tbjoa9Yk2astiymleST
         +01bmLDo1z1L+xFUGyACCPpe0wxBSSuGktUcsp+hP22eCqBx/a1slAmJbvoYET445dSZ
         Gjf+JrGJ1gMDLIRLLQDvZqP7pSjB4TQ+HHpfz8bgiAFXhYxBHm6Dn2WijeANmEnmkF/p
         EOqA==
X-Forwarded-Encrypted: i=1; AKwUvBxzwO/yh5holMyiFhPjaaS6WCdSOwUz1pFFcOvT08LCjVxxF2arZiNvVlRDTVQUwf1U6xJv4vxsMms=@vger.kernel.org
X-Gm-Message-State: AFuF++k+QN4TeQabV7XMiiDvaPMG2Z44Th/NEPapzvRbVMkCTNXMlxRp
	pGCREDyaFOyzM+G3cOzO4bhd9n/hQ12QM0FdGd9R+6YWUctTmu06KchP
X-Gm-Gg: AYBFou11iVpXlKDRBOWwQB9/eDsvICya3uWP359eB4BqORl/b6+T7YrnaGw+/OZQ92Q
	pptxtz+uUcSuCV2i1UrksK91HazhKdQjmP6MjmwC9KTNoGSmB3RNcmrh+NZU7jskYcjjmVCqHS4
	jyAVSISZn+R45LEbVJfbvywD9BtNxcAC3UWmNtd2ETOY2QkDW0Ej0S+3s5GnuUKZiPFtFT+JRsc
	w+IY8mDn99njKWDZQUfE2uw0E0PqFAaEUlPDghGMFo2JVpDQqIDC7P75NPxUoGDnwOJc/UjwnJ2
	grDOmB4D6B5CjivhS0A+rBtH8OVtM5Vg/4mgEbR5snZz58SRdOl+nGLVV49jozoyk6tjCCVgCZ4
	zv45F8k6BiUcUZdNEStUaMbRdlZauiACR8ahA+vLVEyw8Q00/eUkec6FknoX2wMU43t7D6o3ilN
	i0LJRSC/v24lpujIE3VSlgPLh/XwpAv7rc3zKeWvmgxe3h89Ht6sEodDGHMNbrM+CF9cggKYcMs
	NXhdPfcO4/wFT275x6QVEdK+VlTx/i8d5OeGklq8bItCYYnFH5bXOy5MHXqj8pGtr/UOYXHRxNu
	6TA3o+UdvN2JA7Ia
X-Received: by 2002:a05:701b:2514:b0:144:ed03:8972 with SMTP id a92af1059eb24-151c32ddc15mr6493829c88.16.1791110625561;
        Sun, 04 Oct 2026 03:43:45 -0700 (PDT)
Received: from kapoor ([117.235.129.249])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351272bb9basm4019140eec.24.2026.10.04.03.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 03:43:44 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: andriy.shevchenko@intel.com
Cc: jbhayana@google.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com
Subject: Re: [PATCH] iio: common: scmi_sensors: fix truncating 64-bit divisions
Date: Sun,  4 Oct 2026 16:13:31 +0530
Message-ID: <20261004104334.82610-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <asFW-3IPAgFIDViV@ashevche-desk.local>
References: <asFW-3IPAgFIDViV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 03, 2026, Andy Shevchenko wrote:
> On Sat, Oct 03, 2026 at 11:25:55AM +0530, Arnav Kapoor wrote:
> > Assisted-by: Claude:claude-opus-5-5 coccinelle
>
> Assisted-by: LLM coccinelle

Right, I missed that the documented format had changed. Fixed in v2.

> > +			time_ns = div64_u64(time,
> > +					    int_pow(10, abs(tstamp_scale)));
>
> It's fine to have 82 character single line in this case.

Will do.

> > +	*hz = div64_u64_rem(NSEC_PER_SEC, interval_ns, &rem);
>
> I would expect to see this be a frequency unit to help with left side of the
> equation
>
> 	*hz = div64_u64_rem(HZ_PER_GHZ, interval_ns, &rem);
>
> > +	*uhz = div64_u64(rem * 1000000UL, interval_ns);
>
> And MICROHZ_PER_HZ here respectively.

Makes sense, I'll use both in v2.

Thanks for the review!

Arnav
