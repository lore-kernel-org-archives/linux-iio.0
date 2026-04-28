Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C413016E7
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777356541; cv=pass; b=FFk6xxUeU+E3iBRjwS+9G705WX1ReiApON/xE2b7AcaOSM6ZQ5dq6eoyAj5M0hCTFr6G6XEPqVkBcplCI1cvy+/d7wWIhHiIfFN436GnwPTR8LFku3lWixc472jLfPwMRRoS4gLgqFs/tEUAthNtdGuIpHWyp6u+W1IYSTZF1mA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777356541; c=relaxed/simple;
	bh=mUr9S+zB+NqD6QRsa/0byrcWI7Sjk7S/JO07b/ap7mE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwtummhWYoWzYBqZhNMXqe3X33QdeSfyBMTw2vEDLPcxgIQoW5w3UV7O63qjJoBlv2Xy3xInA5S2gaZuEbalIzFbtQHQ1LTucID6egj1lKApfUc5nzlVR7H80JnQ/5AkeeK9nvAZjyuCIQv/7Cvuv61l8Jv47U/w57ZS9QNFvZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovfugXa9; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovfugXa9"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-650140d4886so1289302d50.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 23:08:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777356539; cv=none;
        d=google.com; s=arc-20240605;
        b=S6GRRF4wFvcvlE+LCauoe24rlqi2gARXUns5xhB4tAcYOylgsFTf6Pu3dq/UQh18qB
         Dxe7K4oeI3EwkN+1+G6oyt1loDYQcdLajuLjDWBdP24NqljQVWDuxXP6J8Oetr+uFppf
         lW0UWEt5rhpfGPcBLYx5TjiwbBleqPp/ybjCj9VI9oTv/wFK+vi4dg9qe6pZXUoHmP4Z
         PIScdqInywjxUxu6cM+DYlSQ7LhyVj5QS99OcfnE8Zr1fye1BOCThg3WiW6ojPOKiwDN
         oP3Y0R276+lyQ917NnDqqUiggN76k6Kyn6ihdsNl/dl9wUFqq0R3I5FU/Cx8RxzmIIV1
         903A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mUr9S+zB+NqD6QRsa/0byrcWI7Sjk7S/JO07b/ap7mE=;
        fh=HLqGDkQR8gM0NQlptVFKLv+tij94NL9b/P1cd7ObGCQ=;
        b=A+h3YFmf8oQsuhzM2zJbhlFmo6rWdd3/fiBIQIWeqilRvsTNgwJK8W5ehtUJG8Nt4R
         u5d2h38VJU2AImP+yC3DWKq4937ao33N2xnpsIhIx/R7J62O3ynsIFYemAEtaPMJLOor
         Ee31t8G5CLdulbzdI/qbxeHvbUpm3/xgzZfcKFLHG0We2TSx3ti5oBC6w/W9j15rBbxs
         1JE5zobFO4xkmjk1K7COqVGIExwJulLfw92yc0sWpfxGmNaBZQ2OLn0YvK6jsxPmeu4m
         fRL2cKESwesUfnUwJmIqSWmWzA+FvX3bJ9uGNYas4xXCFiO6GRWeouK7IsytZziK0Cbl
         dWBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777356539; x=1777961339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUr9S+zB+NqD6QRsa/0byrcWI7Sjk7S/JO07b/ap7mE=;
        b=ovfugXa9v+Y18vzlsHfrB8jKYOsclPu/POjib4NEYl5iKSSxgl4WORV5cbfgcuWeqj
         uUPKJcJDtYAd0J4OwKiS3Yb1zyVNbyE2RCJpvgGeC3p6bfPi8h9avjmLiZZEmdJxBvQO
         WgGIMcZ95eawFLvbB/8+7iCXkZlBxkaiVG0Wdamn8aWKkOP60XHP9Cyhdbqwj7nLzwcM
         0wNZI/rjankyPEOUMRyvz2kn3h3tsKvnFBH1yn8yr/CsIAbuEpXr2Lami11n51BDrrVN
         HfXzx+sQ13ve0K160QIrOVsCiS9PGkKd0sAYpJ3owIOGZb92V88ujp1UgrmeWRez9FYr
         X7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777356539; x=1777961339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mUr9S+zB+NqD6QRsa/0byrcWI7Sjk7S/JO07b/ap7mE=;
        b=RP2qPP8XLkx9gMaNFwKl7qfUrG9PF4uI+ou6y3Daeqb58sUmcXOzhvNESeaZZAcU24
         AInknWVGTzrHqn8mU2bdWG9wmDgr3F/UWM65XKUQOt2bvrc+GoIGSrwJ26YW+LnDo31m
         m0FCK2xNA4MuhXdHxAIK2i12WezEZdDhYhqqScqY68QC5WbEe188ciu+K5+a6qAHP9pY
         FeGILJjAN1XIYvEeKxx+jKdccGw8kbDmvCwnKXK1YZ3V4jLcLjcHFBXrK2EgFHmXNeKw
         p03N2OLSUry+ZtHxSoUfEXKw2N24jbPNgvIBpt3jZRZnFZxVhMwWuxspMGVpYooBNGQd
         7JUA==
X-Forwarded-Encrypted: i=1; AFNElJ/oXh7P+lw37MfKr8OQsdOTSVJaeYlw0ZpcTuD+RTLwMnGf/1LobyXOjq5347beAFWzItwn6zOzeQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX6iov9/dug7wQKTfo3OXbBxHMMd4HdrDt+6atokk1vv3Nyq9n
	V5LCurODJEZzDqNU6ctGLAwk+LNM8zwxcBuhX1KmapxBmxHVDZ8DUQNGqbiOgKU2horQo/aK/mD
	1yWS009UqEHMsvBP42xaodxVzhtWcnWI=
X-Gm-Gg: AeBDiesTOg0n5Gr/Aw35JBw2UuqINjfJmRfFKuuyQZzcMHmMJv3CfwW9TpYltaGaR+g
	/VO/MshUWsz/cQD1KBJkazSA1c/d7BFMNBmRWuRYB0TkPmdqHRDs6MOBnRihYgKSUdQQBCyoNR9
	dtgZQpmg+m4GPTqwJHohqq5gFW6AFWG/Fa3Uvr8q378ulFPpwVzILd04hH5Co/galpxF0hMAc4b
	29S7r5eIF5kVL4uGaVOnyp/TyoaiX2z5k76CRbE2xENlpv3gByIEsFRulAYdPiWZ2Uzh3EhkJSD
	6CUJ8FaJg5fECrsF7KnqHn7w6WNeEJb+snZ4nyxmn1T4QLdf8As1UFq0wqVE93ngF7P9jb+LUpl
	onESVK94rGEB7OxdNe9rLl4hU5SGLPECE
X-Received: by 2002:a05:690e:191e:b0:650:20d6:7098 with SMTP id
 956f58d0204a3-65be18be155mr1644533d50.4.1777356539081; Mon, 27 Apr 2026
 23:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427112705.71138-3-giorgitchankvetadze1997@gmail.com>
 <20260427143137.27bc4552@pumpkin> <3512cce0-6660-42a9-91bb-07e78a002205@baylibre.com>
In-Reply-To: <3512cce0-6660-42a9-91bb-07e78a002205@baylibre.com>
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Date: Tue, 28 Apr 2026 10:08:47 +0400
X-Gm-Features: AVHnY4Jf9pUY_HyG6kWzxyaKgt5kRi7hSXwvzmuA1yj5TZstLo2--b1wUPbbh0M
Message-ID: <CAE7dp2oo=BH7-VDX0R+v2VXvCWw=w35-_RSY=DA7UH21qq2d7w@mail.gmail.com>
Subject: Re: [PATCH v2] iio: adc: ti-ads7138: replace kmalloc() with stack
 allocation in i2c_write_block
To: David Lechner <dlechner@baylibre.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 7:21=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> Giorgi,
>
> This is why it is important to include a changelog and a link to the
> previous discussion [1] in the cover letter or after --- in a single patc=
h
> when you submit a new revision. I think that would have answered David's
> question.
>
> [1]: https://lore.kernel.org/linux-iio/20260424081809.61841-2-giorgitchan=
kvetadze1997@gmail.com/
>
>

Yes, I see it now. Thanks for pointing this out.

I=E2=80=99ll include the revision changelog and the link to the previous
discussion in v3.


Giorgi
