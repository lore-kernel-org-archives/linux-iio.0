Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A92CA4E
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778359608; cv=none; b=IHPNHpaBPlB9x3BJ+Cce2snBCJo5kYPsol8aIZSS7S/lpdfnhmYvDHNd/rJ/6PU4217Usz7BoZmnJ1j2QdceJ+ty9PtO8CV2lE3zzTqpM5TV/Wi8eK+zhLt83V+/oVcfYyqerC0pn3+TCkKDf3RUpMBtYYKlMBvubmsk+7t948E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778359608; c=relaxed/simple;
	bh=oDZHhdhmrZxPQGQIf9MGuoiwzo0Raf+XR3EFYT1R3JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLBzQFJCiwbH1q8cS8FohlXdWSusTILX/8O5QcXiiK7RAUofSgSWFN/qQywW49BjgaEDd4wdHriqbO4ewn6RGC+x27AUN5Ls8q4IDrq2JeGWgVRbY10iix32xr0HgtGK5dtsxrwUEuPkUgRD8+4bLQ/kgyaGGUlG4WQdbYvpjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=ZssOb/4o; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="ZssOb/4o"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-479e4835e26so1863390b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 13:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778359605; x=1778964405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRbgBo782eUtJpnhq8Ku3vUzpP7/2BMVUw6BYPei+yQ=;
        b=ZssOb/4oBKAaUrGsC+8Rgh6/oOOjrYVQ0osl5m2beX6A6e0D/SUFPItCEU2g5mw224
         TfDkyiCTUQvH1/XrC142N2cEXOlW15q40lqCS0m0Y8iwKFbT3s18TD/44DkdepxWIjgL
         bf328MO9b2Sk7JhV+BU1GKUrIfbaxVskNW5KlME9gTyfYGXWwmPN9fAwbUF00NtGudZt
         21yz3vl0QprQQLinVTTYj/BjFfEVg2W2k9kwTKbfJGAoLF6HaKPcktINT1Ow7VV/csx8
         ZM289xkH/wn0eaLng5+FsiRk9+9KjeVDFOvZnJxVbJ5QrRQkIgGLoTib0lzKIf/dXTVJ
         7V0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778359605; x=1778964405;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRbgBo782eUtJpnhq8Ku3vUzpP7/2BMVUw6BYPei+yQ=;
        b=bb8k3y/HnAwifJPPdLrdHdQT0CjsRE34Jizl4oFY/mX6e8GcnhgzaI5duHnyWoomtH
         yOLKAH6d05hDokyEoKS6gYnqI9dsE1ZzMgC06f9W0oOYwazlCBOnUYxnZNctju+1/BId
         pF1TL7sGBKqXwvszBxE1jvgHJi7SIHqmASCCWwwBvw37NWh91qoZ4W+uYoj78nCGfUra
         3nfcIkAoz9Pcgz0MZDTEv94YwHeNtxiwNMlvQ4eV+KzAE5f0HQPANqm4cSHFpISyBg/r
         tH5EzpXxFaC1JPSd0RiFFyY/QE7ijAQXGUdJJUXF/WSUpuDAk3/9gOzV2jFcWtXbR4lz
         3uKA==
X-Forwarded-Encrypted: i=1; AFNElJ+cyIm9cS33dAWp2jkfSyRSz5TY6O5dA8JijHxbZ2rwc7uX2hMof8OVMogOU2WWtn9gqMap0cSSGSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLn8bWdW0JUFHnAMw3OSgfhjuGQqJtBEbJbZEu5gXsTVfPUAeQ
	zNorMX39pSPkCbxrfqnnBpLeja0uKKRa8tP/C4XPFiQu79/sOBUxcF7S/MePp0wsDbg=
X-Gm-Gg: Acq92OFg1mA5nlsFZFIVazI9VnTzVnlkTURHhTaakXUHukley0NFl+ziVOf6DH69AWE
	rrfc0kiNLhAtbR7SNdvjyWoYN8pIq4sZr9xMf1E2N7ezVxY/efYI4KcEX9sydb/yWmb6KRcV093
	273qY/TfnCDWGaz6DcSNJYzDqiUQr5w0+aMcnRlmqMDxjIllQTcvWeho0KOGAmTue2NYUpAjC71
	q8w+IP11y8gaR80wxLpgGQDNGdUpU4xMm7hrj77klEvzDHZrAcUNmKfupfhSrhBxDHA1vSLYoru
	JvAZuEeex6dikwIvE936CE4NL3VGGa+krPDs2MkwfcMIVqqCtKh+vTdbyGGX+X+EX9KaD+p0sM+
	lxTJD73SSsqsEhFTrY7OlNq0/QVpr1NMZeJow3cxox2N68kj6Zn0v2ZnwW+7GPr8dfJeiksiMYy
	2sGw7fHKiJnHfZsHAuE2c5e7UFDLe8VUct2CTRSc1bVMbK31qxQOtu5Mv3WeL2q05j1BP9Trwwv
	7+9GxsF0RkW
X-Received: by 2002:a05:6808:4fcd:b0:467:281e:3d85 with SMTP id 5614622812f47-4804249aa3fmr9759745b6e.29.1778359605556;
        Sat, 09 May 2026 13:46:45 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3548:c22e:ea52:dbc7? ([2600:8803:e7e4:500:3548:c22e:ea52:dbc7])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43557371c56sm5051179fac.9.2026.05.09.13.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 13:46:45 -0700 (PDT)
Message-ID: <c95cb4de-114b-4d8b-8353-4689a13bb46f@baylibre.com>
Date: Sat, 9 May 2026 15:46:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] iio: dac: ad5504: bindings, cleanups, and scale
 fixes
To: Taha Ed-Dafili <0rayn.dev@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, jic23@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: nuno.sa@analog.com, andy@kernel.org, skhan@linuxfoundation.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509142047.30302-1-0rayn.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/9/26 9:20 AM, Taha Ed-Dafili wrote:
> Hi everyone,
> 
> First, I want to sincerely apologize for the long delay between v2 and v3.
> I had to step away to focus on finishing my last year studies, but I am
> back now to get this series over the finish line!
> 
> This v3 series addresses the feedbacks from the v2 review,
> specifically focusing on strict DT validation, dropping unnecessary
> driver code, and making sure the driver works perfectly at every
> individual commit.
> 
> Testing & Hardware Proof:
> The series has been physically verified on an ARM64 Raspberry Pi 5 using
> a custom Device Tree overlay.
> 
> The AD5504 is a 12-bit DAC. The hardware scale outputs
> now perfectly match the DT inputs:
> 
> Testing the 60V path (output-range-microvolt = <0 60000000>):
> $ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
> 14.648437500  (60000mV / 4096)
> 
> Testing the 30V path (output-range-microvolt = <0 30000000>):
> $ cat /sys/bus/iio/devices/iio:device0/out_voltage_scale
> 7.324218750   (30000mV / 4096)
> 
> Additionally, providing invalid DT configurations (e.g., 70V) successfully
> triggers the strict bounds checking and cleanly aborts the probe with
> -EINVAL.
> 
> Changes in v3:
> 
> * Dropped the patch adding GPIO control for /CLR and /LDAC. As pointed out
>   by Nuno Sá, since the driver does not actively handle or toggle these
>   pins, requesting them in the driver is dead code. They remain documented
>   in the bindings.
> * Combined the pdata removal, regulator _enable swap, and DT parsing into
>   a single atomic commit (Patch 5) so the driver compiles and runs cleanly
>   at every step of the git history.

It should be possible to do this while still having separate commits.

> * Restored the -ENODEV check for the regulator to maintain ACPI
>   compatibility.

While you were studying we discussed this some more in similar cases
and decided that we would like to handle this differently going forward.
For example, see recent changes in adc/ti-ads7950.c which also has
an ACPI case.

> * Implemented strict min/max array bounds validation for the
>   'output-range-microvolt' property.
> * Included missing <linux/array_size.h>, <asm/byteorder.h>, and
>   <linux/kstrtox.h> headers for full IWYU compliance.
> * Reordered commits to group cleanups before functional changes.
> * Dropped Suggested-by tags for standard review feedback.
> 
