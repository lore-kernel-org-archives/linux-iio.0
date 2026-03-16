Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA7B83DBD60
	for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773685592; cv=none; b=XbqC5jB4AlDLdO/Hko4HEZqUir5KzohoaA66+SKf1beOaeIqLjT86n2Ph1xtQ+Xa/miMmXVsIj0UW7VAfYCNcC5EjYDVTo75i/oUKJDwydrRlQcvHdX6a0e3X4tOr+ySHVNKMTYQZoT65jTgKuagI09pixVj5VTJHlmeSwa+QBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773685592; c=relaxed/simple;
	bh=eLT608Iu65e75yFDY2ephL+DnmrFksL+EdNUoRvOM1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3sjyuKMma6/38Y7rReOrWwMz1BIoIkzvjymsraMx3p6WKxOo3MDhZTra+0pSrNQ9jdyUrCjzEoY9CPUw4My1kqB63YsWhok3OazHqjV2v6NdyHLwWJDnj1Lv525LE7b/pklKqBdZ6PsU7/1VwdootKvLi16m98gCD8VtoVZZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56b71eef805so831436e0c.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 11:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773685585; x=1774290385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpQ1JDIESkHS70bwkrVznor7mYifAlL8o6+MvzPijrw=;
        b=EK58hWIME7G5BWnvF7hX1t4z+ayLyMKe/XO7fA4NrLa+kAOKrsmLrabKqeYK4u67T9
         WBGVtlRhEj3UbNxZ39m4GnNm+P10K/8B06A7+Ua0vheUFv0GbMyLs13nhdvbYSHVNHiu
         8Z1Zq4hOBrA1Gu6V9JneLUS5O+NTpdcnNNgDeps4o/3eRE9YyW4X2DTk1yiMATgGk823
         5vQUpMpfBBozBI/aLaoaGdMAjktlthnfSNEU9rs8pvtDq03+uwHTY4YEg7aAIum9k+Cm
         TbiMMnUfm/m3kH6oTTfbSUa1GdaYlhmHSPukmYQEwVclIAD5ZwO40pPLc3aVWpg/NkQK
         xIaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpwlrQVeloYMVP+k6XJWciPal4t5vVWzRxfEzPRnJXkWMGDjBhUW9g2cqh1AcYHHMdIgn4LMf4BjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9HwG3WPOa70G/TCqKlUYtc2iUcp998zcRz15Hc9homixGF2du
	y9G7WGEi37vQXxPQioMTmKgI3JsBT8epfOAxFJEGm2FhtkUY1F9qjQsRtaG7v7od
X-Gm-Gg: ATEYQzy9hGE7rjGMxLFVbj8JPpEzZIe5u2yzjukuyD4cEnoQMqdClEpA2Mzw4MWR6cS
	tl6ab4TEPOfq4vMtL6SDusJ0e//xztAjZjKq71Ovr7DcqJY6ygb18ZU5LqlQRx3MKOCqleKBTfm
	mlG6ksjDbKSenf06HLra/G8z9o7QZvifB65F1Ky5MMejl0oY1V/4R/Gg4DxJe9PZci3ewzoGrdJ
	BwWIMJP89b/+gJXaPoZofDrHK1dHng4HJAsThkWsYNUJQfB68uPoR+PDM/Ekw4LRE4N3VMtzNJs
	Qrx80avi9nRZ2FMNyOnXBxAwWHgKA7qlxasqay7pvIfqb+07WLlCZZTCcGKq9Xy5xaP0+GUrZjl
	dZPlsnL2oVUxsX1tJGLC0kojJh62gPXcHAqUuz/QnPlumejArddGwTZC3Wy2IomGGSfQakfvkMa
	kdk7lHxH9PIjQfYLTOSYRw+G8j8L6ALbgaobSzAXo7rv8LsxLusFsiJLnzjoeySLZriZ/luVtX6
	RE=
X-Received: by 2002:a05:6122:17a1:b0:56a:9401:11eb with SMTP id 71dfb90a1353d-56b627f077bmr4855168e0c.2.1773685585517;
        Mon, 16 Mar 2026 11:26:25 -0700 (PDT)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b463510a5sm7993917e0c.8.2026.03.16.11.26.24
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 11:26:24 -0700 (PDT)
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-56afbcd8adbso2191014e0c.2
        for <linux-iio@vger.kernel.org>; Mon, 16 Mar 2026 11:26:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3GRObLp/N08YAHqaSV2DsBrxcA5xjrw/IfbxqRQWh4OkHOq/xQlNtL/lp+uRGpK5xLIsFhaCRRxw=@vger.kernel.org
X-Received: by 2002:a05:6122:6286:b0:566:2711:d8ab with SMTP id
 71dfb90a1353d-56b628474b4mr4749468e0c.6.1773685583889; Mon, 16 Mar 2026
 11:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130122353.2263273-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260130122353.2263273-2-cosmin-gabriel.tanislav.xa@renesas.com>
 <aaqTVDQa7xn70bR_@monoceros> <TYRPR01MB156191C8E77BDA44AE23A7D4F857AA@TYRPR01MB15619.jpnprd01.prod.outlook.com>
 <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
In-Reply-To: <TYRPR01MB156192CC838EC0B3DD66246158540A@TYRPR01MB15619.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Mar 2026 19:26:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
X-Gm-Features: AaiRm52-cBzLFzQh3BVzaTMxkTLnHu9mSUGosGUtI9IHFak7XQqS486mq62zz2g
Message-ID: <CAMuHMdVqqGTmxiKRQBbphw8KmtG66HLaZhDVvtSK81cfiMsXcQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] pwm: rz-mtu3: fix prescale check when enabling 2nd channel
To: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, William Breathitt Gray <wbg@kernel.org>, Lee Jones <lee@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Cosmin,

On Mon, 16 Mar 2026 at 16:52, Cosmin-Gabriel Tanislav
<cosmin-gabriel.tanislav.xa@renesas.com> wrote:
> static int rz_mtu3_sibling_hwpwm(u32 hwpwm, u32 *sibling_hwpwm)

Unused sibling_hwpwm?

> {
>         if (!rz_mtu3_hwpwm_is_primary(hwpwm))
>                 return hwpwm - 1;
>
>         if (rz_mtu3_hwpwm_is_primary(hwpwm + 1))
>                 return -EINVAL;
>
>         return hwpwm + 1;
> }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
