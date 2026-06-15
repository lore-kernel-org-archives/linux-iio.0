Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6352E319852
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560711; cv=none; b=SiNWUYEl1SF8TMMS5mNnncjgEtlUCT6IPtN+17vVBhsoF+g68hNrRi27eLSJMOOuMkG4pdjKjABOoLjju8Pjw2bSIQG0JY4IkXAo/sTOonqQGpMJHSNgXJuda/Ljze04Byra4W4eSnPbcTrlYlnTaF3iJgkjI41ZVOF6NRPA5jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560711; c=relaxed/simple;
	bh=ANlTTnx2rujs8icEwYVwf/vOmDfPJfWPempNKnyWF1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TlWBw6bzlgz+h84vCf2j/WBsCRpu1bOU6Q1NbUYCZNhmu48NCGKHU/wnKP3MiDLAmI21JNsiw5ENmoZxHZ4JpZ41002+lZJ369iugtW9SwkgF9r2gag6aJ0mrGSYGAB3pw4bhVVJOqD6zuMUup+PFsYvRtTyujW7puh35TOAssI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oP//JedR; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oP//JedR"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-487135fd4f9so1565611b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781560706; x=1782165506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSPMTFELsjjyUOhnmvtDwdGYg23vfM8IsSaJqyz4M8A=;
        b=oP//JedR2TiumfkxvORD0SWy7n0HRyqVVwkHeQJY2OMH7E6kmVfp48HdotCf+zrrQh
         4hnoXbyRRdn8qvRf7zdNOY9b1Chpicz/2cEHiazeMnhkIor73mvejZWSvIltnvZDJb1r
         CPRBFbmlEHrBWL5fQnHMh9noaYpqifAftx6+ok8r5Vy6tI0Oqz+9AgCMP4FFGaYJHFd8
         PlXBvU0AO84snrHHNcLenEILb46h7BznEysglZsY9An8Ib/n8QyC5RIyL06VmXgukL3A
         SEs1WFNL72rkERMzKoVYAn9K3jpq2pu/ZGCqW42RuDfkr8NyUFvIsA1sefjBIjLD/fIo
         W07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781560706; x=1782165506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSPMTFELsjjyUOhnmvtDwdGYg23vfM8IsSaJqyz4M8A=;
        b=oXCZfZf8JQc50vw/GjV1oX9RAYERjPW8ud5NMVJASQS6vZtUaXiXRD4I+lu3AMWfVb
         n7xCJwjg04wwRbND+KamPLWuXLCPdDSvPIw+02eUUNBKwqz6aMsdHqa2HfZ1mVrXabIi
         vFT/30SMoJrlv68VW/QcwNnlJbFswA7jefoZAhFiGBLESTBgp/D2h/pK0RDgXfJT9SXV
         dL42c6ggrpRV0gv+2fHMRuAqhcu9T0FWA8YMumymJIi8/NFkF4ttC25kKQHH/yIPIACA
         Wu3t6T11ONIPFpv/BKZ3Vxjx8BukaSznuf16oCW/GoEVjk0YigiXZCSBgV3g4VRHfGFq
         j6Ww==
X-Forwarded-Encrypted: i=1; AFNElJ/qDdHwvMczGNIFg4kgJtKY7VnpSq6hNb1gmXMxQ56LJ7Hj28DVerqhV+MBy1e/0mNivDx5Yo6Y/LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqfzKEHID2+EX2mcc315k2ogF9QVqouLVjHlueYlg40uKMkPA
	qFLJZT2KKZBavoiXev9CE6IhzmqmhtBklgxPpXcliHyjAHILiaY07XRrzgvseoH+FAM=
X-Gm-Gg: Acq92OEyq0yYUomb8GuCSHZ67v6eXX6jRl8HWnMfT7C1CBpyDmELH7ywjzdupKxw8Wq
	6pPeJHTqJn17m47sQkhOE8dTbOSvoCuWP0VbbhRuWERlR2g2belKUo0/AX5f+XFm9Pvwewow7HJ
	nIa53Aw8Rnl1c8/K4XWHb+WRcb0zO+TIGsFBANdeYy+Imrq9UOqYyN59BYpJXkLoXH3Esjty6k8
	fiB0VqIfGcJOx26M0RzjTXp5ZnNcUY+mpjuQL7vpYuYzZfUVnfaA5LbTY3iIuqboOFCuMxTBTV1
	A/jrpkZP5j02O9q7DRs0MzTqlq10zx+R0tylzkqOWO8AE04aSo3kfr66P/kXANCmor8sY40wfoc
	nF2kCn02/f5N7fIuamIyI4eRspIUEimyA95wSzZcWe+zfI74VF62rUG/9gjg351YfE3nP78CARf
	W+Q1X/VnTAqZRwPPnwym8kXIoihiH3V/DMrSN0k2QSv7TW/ZISWdHOFt5oUSxFkrbS8XewqPgMk
	YFaBR1/XBi+
X-Received: by 2002:a05:6808:8613:b0:480:4024:3bb with SMTP id 5614622812f47-48741ab6e19mr5485120b6e.24.1781560706142;
        Mon, 15 Jun 2026 14:58:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:16b0:5133:47b1:a939? ([2600:8803:e7e4:500:16b0:5133:47b1:a939])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4875ddd5729sm3361328b6e.5.2026.06.15.14.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 14:58:25 -0700 (PDT)
Message-ID: <50847348-5c67-4189-ad26-e41ed4ea1720@baylibre.com>
Date: Mon, 15 Jun 2026 16:58:24 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] iio: chemical: sps30, scd30
To: Tomasz Duszynski <tduszyns@gmail.com>, m32285159@gmail.com,
 jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260615200459.8272-1-tduszyns@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260615200459.8272-1-tduszyns@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/15/26 3:04 PM, Tomasz Duszynski wrote:
> This series replaces old email addresses with a current on to
> make sure changes show up in my mailbox.

Would be good to add a .mailmap entry too.

> 
> Tomasz Duszynski (2):
>   iio: chemical: sps30: update email
>   iio: chemical: scd30: update email
> 
>  MAINTAINERS                         | 1 +
>  drivers/iio/chemical/scd30_core.c   | 4 ++--
>  drivers/iio/chemical/scd30_i2c.c    | 4 ++--
>  drivers/iio/chemical/scd30_serial.c | 4 ++--
>  drivers/iio/chemical/sps30_i2c.c    | 4 ++--
>  drivers/iio/chemical/sps30_serial.c | 4 ++--
>  6 files changed, 11 insertions(+), 10 deletions(-)
> 
> --
> 2.54.0
> 

