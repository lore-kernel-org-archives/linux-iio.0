Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795505388;
	b=ugs1MzfslD4M1T5MFCCxjHW1QDdN3gRFYXNWLSjxhkigvuysUQ5YhpQ55VIU01R56Oqa
	 naHLKziBXtMGKIMKfbYTyCQU7cdKJZw3I6gUh8Fk+5QHOgMRjHSHZ5EWqMC88bN9FSS7O
	 fP+KOXotziGBZCE3hbbAMvCsd19TauMUgUmsaN8jghDlXdY9KAuL7/EhFxu/K+JfYMQxn
	 chJDQngyGkV3DoJgiu1Ot/fEXcYM6E6yOLrr07hNWs2KiPsCpJpuS1kHJP5V6B9LmNadF
	 5dYrBmP54OkD10IaGnvNegZLV/4NYKsZbRYW7XolUtiDQ1d1xwJufMJdzZbSexmQf+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795505388;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=HHoAin8im1fnI2MFH3oWDJgzqw5jsSnp9Q8nmC/cZc0=;
	b=B+LKMKECorN25NEEqJFVRGIbRn8n8vWiQfbGQeqm6wjJ4reNj+HmUHlOEy+FD/FsEBld
	 Ng1QtWvJWnCx1EOhgPkvr1MVekRKyq+JEiLsOQ0rBrAako84ouegsakCp77tZPjWm/4iR
	 rNjLASkdaKHIDdr3ULO+WWgWTpTSTFvCC+dR+iWiTLtanNtqKk9ixj1NMBoEFzM5hJQGo
	 an4qWbM2Mm5B++ARmOs/528tHMpDmMhq9N9hsKrzj19jx1cYV2yuS1nRQWMuRP8ckyHiW
	 5fFZX8bkUJOhBA9bwsjfcHIly7QJfXPF8WuZ9tqTpATIaJNG7Pmlo58SE2VY78G8vhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jAixZFu3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE635606A321
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 07:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE635606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jAixZFu3
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c1479be604so3105782e87.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 23:29:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795505386; cv=none;
        d=google.com; s=arc-20260327;
        b=GCEioCIJL3mOlV9nTQAODDyCY//9P3ojvXLlIO3YQDcwMl2cSbaWUQT7sy7wuRs76V
         5toEUaU8tgcCYe81KSybFJUNTtr0IaME60RrSlzwRc0sbxPfC37TJOAtIZ3/SrBkSo5k
         S6S05g/FlUDD7UOpR/N2kAUybtj7HXOXWzxi7gHEm+yuaKKRf36tPHRwP+T8tiU51CbC
         pKDzXd1CBKhElym++/IvZWun5i9kF+pMiFDsfWXNMePp83yW8wYJInwWMbY++SC27StF
         ibvyHAxg2yQQH1+7tl2yUmjs7jnu5TdQ2JFL2wRFsXzXl9ajy51nu9tWfiYYjl/zVvUW
         MV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HHoAin8im1fnI2MFH3oWDJgzqw5jsSnp9Q8nmC/cZc0=;
        fh=5nImarzK4Tod+hDRe8ihZgLsmwiGDYS03GL5GENvf4E=;
        b=JquACz9luYDfnjT5q4c0I0Nk0acojJApJ8kjbLzce1LrrhNm8VfhhBDFUbC56GN3Je
         nSNx5FEZeeYjyj6kVYZrkwhi40KaQTxrXfjdAC2fPvisUJg26MIdPqiLuHi8LJ0loidB
         6E5q2+pwPqoxNfeCfWN57XhywA6guC1gYv5TfUFgruV98N1dA8gGkhd+Bf5JQ/iYbY00
         hQvYUKZlv2+NSLzEldhW62q2qXaniaX5u/2PbjZI0zI6DiuQQdYB2pUwTzjypv5BfSYc
         c+Pj54P314YeqleLWmhgnAd1qnbWizeVC0duF3A7BThW2qHRSvHwE/OAzd7jvbX+v9D9
         nvRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795505386; x=1796110186; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHoAin8im1fnI2MFH3oWDJgzqw5jsSnp9Q8nmC/cZc0=;
        b=jAixZFu3VW6Q8y8h8D057mrQVPM+4cfJDCrf2C7P5dF2CiCwvXa/9S73S8BIyfE+w6
         nMm3UIXGY/ki8oLCM9C7VtiExP2TlTwc2IqxtH8JA12fJ+5xoZq6fOmNYct4M3xDDnWS
         WmSwRuCzMTiVnVmK3/oaTSV9kFnSDqJIDKKNwulJL7/NjycKbtgB+PIhHexyVbzauNKU
         iv5+2iaDYE30aqXcMe5h8pgUQ6nb4cHD1wBf37onkVkCFCYsiGSxdyYr0C357D4yU+E1
         BlSsT0VLLI/aZ9pGw1OzkSpV2P6r1I7pF33O6VmLt549WoNiM/JHhBAD5oii3QinZRUE
         zC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795505386; x=1796110186;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HHoAin8im1fnI2MFH3oWDJgzqw5jsSnp9Q8nmC/cZc0=;
        b=RGnXpdW4DB0kxsLlWjcaqOrR1j1ozHCprhYys2W3nSrL3ukO0fHl3s73PobTEovPgd
         M27MonGqTSUKFp72CX9l/+wUmviMEcn++ORzN0/6NsCCFP1TSd215jjJFBSTycQaUGSH
         hLf1iKKuu+NZ9Cyta9UWsJNoeT+rIBCIi+c2uSygfZvcJ780DUapzhLKKsxUrsdsWsna
         qlicsyhVTPiYIvQvjHfrQUyS+eWEpxS8f7ozahDMVJ2eT5U3mxEJE1S9qCLEHwlYcsRx
         pLVoubzZeDFl26JlEz1OG7eozbyCBv2S9yKuZbTKnTEO0vzsSWwv3yyvbZbrmExCyIns
         EKVg==
X-Forwarded-Encrypted: i=1; AL+hErGytrFXZnBJ+9Zcd6s9uZ+57z22nM9PIAvAt0pgmWAVjlChFcEVhDEjQal1ADKdN+2TNQhL6LVqcZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nPVSmq/XKdNJc4yKnujCUfhS0urZdkcD9xNMIBJfaIttq8/u8
	iMk3Wa4Gn03qitZReeaOGq5tgAZ6m9+t9IeI8Oz+W7H81eeJIcr9UxuKuWDziaKjBv91Borf72y
	Y2XWF+Y8fd0n8Txx+IYs0IAcm5dCeHiM=
X-Gm-Gg: AZFdTZf50X66C+qa/RUY65S+itKrMyycvnwLWg0CssG6zye5LawLfGOse47ZVWRuwG5
	YDG3SIcTitXnzRnJbHzR/+KgH+Omtb6Fhn8Zlna+iIS5xRNxwKLXZmLuJpC5ZPDa1k75w3jx8Va
	kyfe++zisfmhZx1D6WNvJ3BarB2Mo7QQ6hqShb8lTc4wRGE5KcoxE+EnjsrFOCoSdyBUOlWkozf
	fNFSLgRAcXmZOnGI3+1/v2y6WRUyDpSiDZusvBuKcUXQ77ihB4iiKGwq7hrkGjDWLVob5VjeBar
	7RlmYdWdTkgIeydKUF9AqRYXe2Ox17zaFPNTQVXIItgwwC67tchbRlc6GWXiNg6Di7STykZbWQH
	Rx8q0b4RVl0qqpPBJ6bidGut8YUqr3mk2e+8=
X-Received: by 2002:a05:6512:3087:b0:5bf:e540:8606 with SMTP id
 2adb3069b0e04-5c1bc898e67mr4261475e87.59.1795505385842; Mon, 23 Nov 2026
 23:29:45 -0800 (PST)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-regmap-kunit-val-bits-v1-1-a1cd02063217@gmail.com>
 <av1qOFxolvDhQTKs@ashevche-desk.local> <a93f6d11-22a2-42db-81d8-297240c9bd2d@sirena.org.uk>
In-Reply-To: <a93f6d11-22a2-42db-81d8-297240c9bd2d@sirena.org.uk>
From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Date: Tue, 24 Nov 2026 07:29:34 +0000
X-Gm-Features: Aa3M54ph22eAMFVDyRykrIGrEABI6AhQfgi6d7a7zVpyiMmcsmVRWIA2hsRMJvI
Message-ID: <CAJsKa+4KEU8ejsDvj0=qCh3=XC5dZZNv_X+Saco4Ln3Y9q9dOg@mail.gmail.com>
Subject: Re: [PATCH RFC] regmap: kunit: add tests for values wider than val_bits
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Nov 2026 at 11:30, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Nov 18, 2026 at 11:04:56AM +0200, Andy Shevchenko wrote:

> > Do we really need those explicit castings? I think they are already inside
> > the byteorder macros. Also we have be16_to_cpup() and le16_to_cpup() which
> > might help.

> If we do need the casts that probably indicates a problem.

Yes, the buffer was declared as u16 * while it holds __be16/__le16
data. I will use be16_to_cpup()/le16_to_cpup() on a void pointer in v2,
which needs no casts.

On the main question, Andy wrote:

> It means we can't enable this test cases without addressing the underneath
> implementation(s) of the regmap. I think the proper solution is to cut upper
> bits on the regmap level, so the cache and HW will see it as expected.

Mark, would you be ok with masking in the core? I would mask val at the
start of _regmap_write(), before the cache is updated, so that the cache
and the bus see the same value, and document it for regmap_write().

Some regmaps leave val_bits at 0 (e.g. ad4130, ad4170-4 and
phy-cadence-sierra), so masking has to be skipped for those. The
reg_update_bits() and reg_noinc_write() callbacks do not go through
_regmap_write(), so I would check them separately.

The alternative is to reject such values with -EINVAL for all buses, but
that could break drivers that currently rely on the formatters dropping
the upper bits.

If masking is fine, v2 will be a series with the regmap change first and
the tests after it, so that they pass.

Best regards,
Raffaele
