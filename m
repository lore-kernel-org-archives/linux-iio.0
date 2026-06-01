Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760283A4F5F
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320916; cv=pass; b=uhyzNw7hZcGSjT/rndNQ/VvnJoAlkcWa+g2Hbq81gPcwqxaU1l+rOxyr4II/6MKIndHM7gd2eXANa8x9o8Omn8yALkltk+Repsdvxcw+q5A7Xcw/eAcl7sQwHziU5tIzAxg1aELrObekb9w3Um9mmZmUjMZDhFf+WbeKxtEDhGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320916; c=relaxed/simple;
	bh=DBFL06ayIBjlRarApEht6OCJL6sETF3Owjgdj+tMMuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSBq4wXxy7kIEG4bCjLGGMlt5TrbD8EC5Kz6oy5G3Sbh2jIpizoszHlNQK0eyFaAyWjVMAEvMxwMEinNheNGAkRqSmGS93O3VuoeT3d3E872GGavo76Q30p0TRe/RHl3SLuTrP/jAyqZEPSMOa+RsVI2vCwMdqB1vMLePJrQ60Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZ3OtDkh; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ3OtDkh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45eec22fab7so2143061f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 06:35:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780320913; cv=none;
        d=google.com; s=arc-20240605;
        b=LHCXLxq27LR/GgbWN9rYpWBt3AjRmALuq1RLgQeNcQ858exSsHlOqe09TpHvhus78I
         pUJoD8W/qYSMB60FRKe4tU6X+M3IgsQoSR90Whd7VzZ9Ljotu3XudX2l7APi3QzGd7Ph
         vQwB0g1dq+v3DbOYZZv4/LI4ixc6MDlwUBT46dD4/v9rhTijuD7e4Mqj60fuBNCCVd7d
         GHvDHATJRT0Sm4/M3HI1OaG7bvQ+EQEw4rNkGP1uPdPg73uQEecPyxU9IonceTyfSoIf
         iYc/5RF8JckFsqdA5wF+1Ew3BrEH57JIcArYXrgvgUNrhhC0vOGOxfot7pKiBeTHznOA
         7lUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zEtML6Ukju9lzNbIBK2QtRDO9JGNsziTxxzGbGkcgbU=;
        fh=nlFvG+dEgJL6tB+IDpw48kit8qmqI54PaBzUDtuBIls=;
        b=FPugSUg5uFamEZiwNZ1TVZo727zdsQ5YwOgKNVSBuNnUPmi5lCvKxOPjJA00FY8ifc
         S6YExMUxIhGJjfpWH0LvCbYtJUTsEYnWTgRebC6T9dCLzbXPCoINbhzAVy9A9C4zWhyN
         urB3vG3XH7TlnWtyzg+Hmw+JGF8Inox3loudhOZFpQaFKWZBGoGV1PUGleFRYxn5jLmP
         EkxZQM24FBdcctAtm1PzKm7T6sx3a2TFTQaYWxAQe3zZ7Ky+sUHbzwjDs6NDYZxAr/X7
         htj6X6FCQVlftmGEnjDHotnIepUapKLUPHElO0WAY0fa7I6S9SfynxP+L264K7XQ2tf5
         gkLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780320913; x=1780925713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zEtML6Ukju9lzNbIBK2QtRDO9JGNsziTxxzGbGkcgbU=;
        b=XZ3OtDkhKYwS1/Z35G31Zwv5WdcOMlxlnVV6wtWeRTfYKo3jsAueQKQXfZN6+L/XSL
         Oz7DH80Q9C0eataL5XeZTWe8uUkwdGFL9pBBGMf3oiQbTiyeSQPi5QNfH/W3YEP1RGCG
         MPF6lxa52lwyLx7G4nmXoDjBO7neue/zLUg6b1tYS1UajNa3xW7lhMQeHF7wVhtOKvWe
         pLTBQBoW6cKcXVBjgZ11j0IsuiitDv/0qCQynr72spGto8XjyoGjd2xlNW3aZ9fW/+Em
         1hBySred468MoM3rN9yeF6MvKoKXO7IOyLW0Vw3muRPp8BIEl+CMjtObDp2gwqKFu+MO
         Qg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320913; x=1780925713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEtML6Ukju9lzNbIBK2QtRDO9JGNsziTxxzGbGkcgbU=;
        b=AUbELOHMjgvSLckdD7xADhTsBS2irRZZtiYtnk824wV8JHesd23ZxidPkkJ2V+B5gl
         Cv7koeECwsm8k/PSpGKuKnJuKye+aUOfBwXX7gERRq7u15za5wgtuOzrLu+nglM7REyX
         v2UqJicquc/qpfWv4ovZXtRSloDP7isqtggAfoPtHMH+N5ihQ8GavonBjsDxLJzXI9uB
         spXtzh6la1vrZ1RPzrA5YvC7g9xtNG2C6E2j/vUtAt7cjaaP+izAec9bld1I9WXqKQXT
         oXPWkG3U6UEaa/RyJUNHsAr6d7cMEXau6IRKIdjLgdewo0Jx/0ENvSP1NeeYiAQAavfg
         XOYg==
X-Forwarded-Encrypted: i=1; AFNElJ/BRb1E/ONhnOtjKB/Ydtm5kz9DasgbqPcHmsjrxdX8Rizyw6m7l5LC8RurmCw+lXg6UjjPPv9B4AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/Q/B+WI2Jj2hNUfFAZThybQlcqRJc9EE9x6HzPnzjiF1mimB
	XeivX1MUzzewdIXIEREuHkLNasrC6nT0VvuGds2zZMzQf2y2gy09gs11g4zvlf2mlmkjC+3Pfcl
	04y2XpNqSoNT9IAQUHDBde8amxPYMW9E=
X-Gm-Gg: Acq92OHNL0Syooly3SdWYv3uWDW/Ifi+UO3XRSJGX7CUS4f1JllXE7id21MkG4/btkL
	2bv/cGsdxGKJB06NrriaO76SxqpVpqer3TxZGrzZbhGsxTpP+y7C7yTCWUWOuEJ4+UTANTxHgSe
	1e7VYZp6mBvOvIM/8cNSNMlv0npCT6hV1QcYJbVVlrIT/FFh1gXdzRwtosqNdxMJcmQvMe4K98M
	l3csYbCBtRTgQMX60CjS8yrgcO1wgziCZUlQwyN4nkp/ONQvcxPRYwiCEB/Ox2I0VVf173OXxdg
	vk5EiCobhRoNkDnMeJnZUPjGZSfXuXfKPE6Bs+GhYuGqYF0SlFo7KupnypmrcvD0qv2arjKBjEN
	H2QtzBgirVL9joYbe3/E75dVo52i1HRsDwWnfZmg1fdLLWGomGD9zeAVnIU3iqqw/B1VJ2Tu9B7
	iTKHqKcR14YkN9A3vCo6I+xxi/i+s=
X-Received: by 2002:a5d:58e3:0:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-45ef6b17306mr15535155f8f.11.1780320912462; Mon, 01 Jun 2026
 06:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531233828.60697-1-m32285159@gmail.com>
In-Reply-To: <20260531233828.60697-1-m32285159@gmail.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 1 Jun 2026 15:35:00 +0200
X-Gm-Features: AVHnY4KBxMJm6fbV--xVloPC2vffbE5TyNxIui3U8P1qhClH_6-3JjQKb3uX8c0
Message-ID: <CALoEA-w1K5T8dug3wJ99PV_-YvMOtM5Xr4==48=EZKdgTRgS=A@mail.gmail.com>
Subject: Re: [PATCH v6] iio: chemical: scd30: Replace manual locking with RAII locking
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, Tomasz Duszynski <tomasz.duszynski@octakon.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, 
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jun 2026 at 01:38, Maxwell Doose <m32285159@gmail.com> wrote:
>
> scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
> calls. Replace them with the newer guard(mutex)() for cleaner RAII
> patterns and to improve maintainability.
>
> Add new helper function scd30_trigger_handler_helper() containing
> the critical section for scd30_trigger_handler().
>
> In addition, small refactor to replace "?:" operator with regular
> if/else returns.
>
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  v2:
>   - Fix callback issue as noted by Jonathan v1.
>   - Refactor critical section of scd30_trigger_handler() into helper
>     called scd30_trigger_handler_helper_locked().
>   - Revert removal of goto in scd30_trigger_handler().
>
>  v3:
>   - Tune up helper to return early on failure condition per Jonathan's
>     suggestion.
>
>  v4:
>   - Forgot to commit changes listed in v3, now fixed.
>
>  v5:
>   - Remove unneeded comment for scd30_trigger_handler_helper() per
>     Jonathan's suggestion.
>   - Change name of arr_size to scan_data_size per Jonathan's suggestion.
>   - Change type of scan_data_size to size_t per Jonathan's suggestion.
>   - Added blank line between return and the rest of the function body in
>     scd30_trigger_handler_helper().
>
>  v6:
>   - Fix issue where names for scd30_trigger_handler_helper() did not
>     match per Jonathan.
>
>  drivers/iio/chemical/scd30_core.c | 66 ++++++++++++++++++++-----------
>  1 file changed, 42 insertions(+), 24 deletions(-)

FWIW,

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
