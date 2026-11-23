Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439880;
	b=esXYK0N7iMF+KK+ZUyyB/y8rotQZF52MQ8034SDyzrQXLFN2rZOqvpru9lrEVN+fcfWL
	 MoQYe6MS61+yvNNGDnFda8X94iaNi6HWOt2bytbvHF3FBvBzcVQyA9dCjXGnwswHN8fCJ
	 1Ii1OpCFik0AkcjeivTWYs4P7E3jUVaVJiFREOs7jFnE6rx5V3rEQN9vnw+njRSpPEj8B
	 htaj6fNL+2iCtuK9M8Di4RmFhhZvElqITMB9C33vVd8mwek5aP5dEjDIiRTbHZyKJ0Kys
	 QoY95xupTClKSOIl4ldYe1LoMi0ct5ZwWKOWX3aZL93Wp9k/MCAdPkCktWxGwslbOzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3OjYQ6M/mHPxju3Ug4nqhzHldYVWjqYGeM/WmXgESP8=;
	b=NAJk4LnDJvxx68l7RRINKDexS7wx0e0wA0eT0j/iGSKadye7ad9x7B3w4yV9EEs+ReWe
	 9WtlghzUSN4EZco8vg69Lnw05DVNL8X5zZsYl86lOKKaNS8s7FtRGuTq1R5FFR3+/kt2c
	 JSsrClCdDpNeo0ej3XpqFuhSHKkQEh8OTN5+GvYQAD7juWeDTAV+Y6iqmQITgz56cTqeW
	 HXmvgizzVxXlh9kVmsRgPwV56N1U2eFbZiXr11Da5LTs3gkAARJDEKPasNymj/oM14PGl
	 SyMWiVeUu3glxr8HTYNKg6T9C/VnP9ZVScC73XV3f4R3BFZ2BtdNxLhKjnmFJxCIC0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GBCxiP/V";
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0636606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 13:17:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0636606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GBCxiP/V
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a070781f63so1441210b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 05:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795439879; x=1796044679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3OjYQ6M/mHPxju3Ug4nqhzHldYVWjqYGeM/WmXgESP8=;
        b=GBCxiP/Vin7E39F9175BR+9FM1bK5oF8SIE751dacjqD5EZek72UDTqSMvDsXVg0C3
         SVq12/gm9+LYq5JaHQ0qr1vsed9EXIbRcY61/q03UyoQIQZ2U2LANVC2L+nImryxPUWq
         guokyhzQTvNvhk2YXAOWgGBQpeMm1bLqcMMylqFuNcWu4w74hYfoFxBbokZLxD1ectN1
         cM/bOjuRmglmBQutREyGOyk0U8yA2TigX5BD+Pw/MWxMkSPN077GfOnJFxwtV+w7eY6m
         w/nGCzB+kmT14BWolxiKQ4Yxn3uzXqzIvX0aInYFQMn9Y8BqlJgVFjBJop0qKWAWoXI+
         6rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795439879; x=1796044679;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3OjYQ6M/mHPxju3Ug4nqhzHldYVWjqYGeM/WmXgESP8=;
        b=DZjCq+UUUhA+51/mzFz6iOwQvJu5Fb5DrcZdnEaiJEP2AYok3VmlEI3Tf0cvaZ+Zd+
         JKHs3MX6J3CCoWDrubdJJUGcCsEe7TSJxZoZwxi/oyYsC9xiWWfeiZ7MQA1CKJG+sBGT
         /JZFNjQMPfDSNQrcArEL7DFaaQAvDmCadpHBolCy+hmJmxl2MwX42lwmr3NA+oJys4c0
         ea3XtChsB+yfJEmQYTXAE+DCPYy6Y0DqfsEZ1fRRnzKpuJ6W/k6Qhy3GPZFTxrTCXyAO
         20azPUNRMfBaVIwSNq23vUC2qhKNhmfuJXkKxJVCUvORzG7w4sBs4bVgfu9ViuNCqeYw
         w+uw==
X-Forwarded-Encrypted: i=1; AL+hErEXFmRHsVESTFHNueL9XChklnga1GwnJHmF9ST0pKO5hY2qjY2KKWWHKxVttz0p/e58qWqoE1fo+CI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/TbBdhFahl4uzFCddp6ba7u+r8pVBh+t7f+r0AKEa8Pz0k2zwS
	mXmE2Jc6Z/8vEdzCbcDCaQf2UB/rpJ4CxdkUIa67Hi7vKXbOVSdvuoE4
X-Gm-Gg: AZFdTZdUZDKTrEg/mO5mBiiwcUbZkj9TnqSJ+GYunox0pJBcU8ixH6SnxCNuOrz5q0p
	gn1NcKh1ay6uzQf6RNSY95FYIcpcc2hRMj7NQjZkQGivj1SfB6VnZwck0Rv+QBiEo4A7SMsZiXR
	9SXLFdM1RHa5GdyexxSgl/L4B0eJQz27Gv6iWAmCabs2DJIq+dth5MJ3v1MtBhQRm2HEep85ZLA
	M1UzIKHomgXwB0skecfnWPyJQN3Nu+q2TgFVof/nf5rpZQ8YnfAOvXO5EsmVN7sHIuFYDSc2yYx
	OfbI9arYKeX5sPMFaakJOzoTCbqLj9ctaZfGDfYoFsDtWaiv9kWlv70O9A8qEF1Tp1EoULdegXn
	B+RzFXviwYt8IL8NI4I3Fd7p3ljLIJv9zZAlJQXSj2ABWLgvfwPO5b0/IB4C9EVL6rEYUuA0Ftu
	eamO3UEPMYX+JDAcHUA3PjXkDTwPPEDNbMPmKQoUgruGrSZRyWOOPOrn7Fox2U7WtR4bU9kzs8G
	iLrNOdNWceI6j00G+GTLb73Z/fMFod9ioysoRIn2Y3MyaDJpppFjM/cXb3RatYTbGw90XrO4HmH
	reW9DCufI+Bq0ccS1aGkctclNDTRxX21sXQPl5SM6e2o9H50/cJXxc0nvHJlrV9JZszAos2GrTI
	/Us8+6MCWpbNTwcmu1NG5Rg15n5AWF48qJeFTgbSPYxpy2LdcjraaRJPpFDGR0isbJ1hN8Tv2t2
	1MySFY9GQRiyDXvSyYbSSPHv+PyoQgNI4Yei1Rt+tZxw==
X-Received: by 2002:a05:6a20:7346:b0:3e2:86b6:9bf4 with SMTP id adf61e73a8af0-4014ae7ca84mr11666681637.14.1795439879025;
        Mon, 23 Nov 2026 05:17:59 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b27900sm5605698b3a.47.2026.11.23.05.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:17:58 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gwendal@chromium.org,
	swboyd@chromium.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: proximity: sx9324: reject negative hysteresis values
Date: Mon, 23 Nov 2026 18:47:48 +0530
Message-ID: <20261123131748.16791-2-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <awQg6X1ay0zyyyaf@ashevche-desk.local>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com> <20261122074649.239441-4-kapoorarnav43@gmail.com> <awQgWmI3HmyqTcrS@ashevche-desk.local> <awQg6X1ay0zyyyaf@ashevche-desk.local>
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

On Mon, Nov 23, 2026 at 01:18:01PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 23, 2026 at 01:15:42PM +0200, Andy Shevchenko wrote:

...

> > 	val = _val;
> > 	if (val > INT_MAX)
> > 		return -EINVAL;
>
> On the second thought, the original < 0 check might be cleaner... Dunno.
> Jonathan, what do you think?

I'd also keep the _val < 0 check. It tests the value as userspace
wrote it, before the conversion, so it needs no comment explaining why
INT_MAX is the limit. But I'm happy to switch to val > INT_MAX in all
four patches if Jonathan prefers that.

Thanks,
Arnav
