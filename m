Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7B2FE56E
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273490; cv=none; b=gfHorBSYtTZMACHVYqMnv8/SfqK5hLq9DTl0dO7LQDd3uccDGgkzedAzrGfHL1IEpnTlfozuFRQDAJYaWRpNO7BMNBiAeExwtIFIdO6oOlg6EHK2GGk/556r/BufCAmD+EKtnmJfRifr2FmdLzB4VV4ccW40wy1QIBbnSU36nbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273490; c=relaxed/simple;
	bh=Y9Eduw3F2r8prTlRcBvKLTOC0P9f8Jgk7j2YnKSkr7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=E2HB6qcgpFcVAViRUFzfRaZKbKd+cpUAh6Apd53SWPbguwCH3glt5/WII3gufCSOIZ48nxNvhyv5iipxc0oa/9LoS1nEtgv9IcK+pC9InmyRsV6W/CmMB4Ve0eZUhCeGVgd6hd0CCQJp/aFBTbons/DJVy6dJoHUZka/+bOAoIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slwFc2mr; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slwFc2mr"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6a308736a36so1333960eaf.3
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783273488; x=1783878288; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Eduw3F2r8prTlRcBvKLTOC0P9f8Jgk7j2YnKSkr7s=;
        b=slwFc2mraQimWr3Xrr/0ZmJO+qWFlB0qVw81NTW3q+E+D4tBWixszwVEvKttZy8u5G
         4A9974yg9hX478Ttb2pV7yLfwdy+nvL+KBsaU34MvJmSoSIncporato8PJBfW0nQHr5d
         OzfpBPia97BVMcAgL0b7rRGl13GFGb6aHw7aRs5UQoYCygu4w3xKl8/j0oKfN6q+mwhW
         yeoyLvw88qm+YhDQSUTMzJvl03AbO7ewJKaJrNf1hMpPZWukMTyHxtjVZUCP6dY5vPom
         23SMIVs612wriRr74JBPHjYF+7oLCb2l5pB49wvItchg25Et7rZDdzcUyM9V4rAIwmaA
         huZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273488; x=1783878288;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y9Eduw3F2r8prTlRcBvKLTOC0P9f8Jgk7j2YnKSkr7s=;
        b=M83TBnQfavVAgefv/+tQ3TcwjNPviRHhfWC4aVJj5GO07wM8xkKIun5um2x5BPRL/L
         aDlsLKnDVmDCmeXs4wsmPHnxmJdjemJ+NAZiejMH69pkLarAB9heETBUwLaIrv3RwB+T
         Oxn5n/NgvT8KAeHsCPCGNGmyUrreFTMRUkbGWw2jyiw2i4DLYr45w4fysnuFUfKyx3UH
         OUmJ6Vkw0G+FbJctVpuLXVtkRSnMDbcDAyZ2S+v7xAfDM3Ylg1nvufo9wW7FSJ9AcSwg
         EU2XlGMogaHBtVAoqLANksxMFXtqsNYtuLH3FTCLaI2czzs88Nrj/uRL3+dPCB4mq8yC
         RVBA==
X-Forwarded-Encrypted: i=1; AFNElJ8/M9p04HeU1w2I/+tldVKFyl9044frd788jt61q6KlXcvok+Tulf0i7roTESPT33ZsDnzdb6Fgf+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUMROjOvXZDWY8xmN1b/maibc4nUmxQ5zeLyA0nXNVwI4oiii
	Agf1T4RpzK1MYFkQUuXqeu1ipqQdBT3mOSgIGhuED2TNy0B6I4njULDs
X-Gm-Gg: AfdE7cng6Rg5sRksEvD/u/PAvfZ6b0vDucAmPh/LycCwKMrCHT6/wBeWmZIbcJKm8H2
	5nOdsqB2E5LA7a/CNLLw2o1FD2HC6JQwxHFODqzrnj1gNv01TGTzey1y3FlOaRmAHf0WaVoJkr/
	SZqlScu+SvNxFGNGO/SaNsZKPe78v1Fl/kJ1X2ck8XFAcWgHcLvOc3UqDKP/UQoQlE0qzvtx58E
	or7XACpqY5wIVRjP6BWPmST6bw1X4BXR1CdlZctcfbbnGZTI3O4BizpQiqyqDJqBcBS6whU8lrc
	T2TLE+lic+joQgcduQaMc6N1Du/MpX1WeyrjSoS/wa7MS8TqlrczWqPFoQVGXwDGaYyejsDfRXw
	Vtf5kKXeB668eN8A0wX2hSCpPzIq7gmTIzovEsR85IeZtx4nP4lMK3xP5d6c/jYOU8vti3p618L
	vLQpQ+PeBeeXG7ygJL3R4rEQcz6kTcqU8FRA+EvGc=
X-Received: by 2002:a05:6820:16a7:b0:6a1:99fd:5a00 with SMTP id 006d021491bc7-6a32f4dd926mr4682006eaf.27.1783273488142;
        Sun, 05 Jul 2026 10:44:48 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44cfb1bb17fsm7877267fac.5.2026.07.05.10.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 12:44:46 -0500
Message-Id: <DJQTOY88KR1E.1U2393N7KUH12@gmail.com>
Cc: "Jonathan Cameron" <jic23@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Michal Simek"
 <michal.simek@amd.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: convert Xilinx XADC bindings to
 YAML
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Mikhail Lukianchikov" <avermoal@gmail.com>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <d7607a98-f5e1-417f-ad64-d0029c9de662@kernel.org>
 <20260705165620.9818-1-avermoal@gmail.com>
In-Reply-To: <20260705165620.9818-1-avermoal@gmail.com>

On Sun Jul 5, 2026 at 11:56 AM CDT
Mikhail Lukianchikov <avermoal@gmail.com> wrote:

>>> Convert the Xilinx XADC binding documentation from .txt to YAML format.
>>> This conversion is part of the ongoing effort to migrate all DT binding=
s
>>> to a machine-verifiable schema.
>>
>>Sorry, but what effort exactly? Where is this effort documented? Do you
>>have a mentor if this is some sort of mentorship effort?
>>
>>And if this is ongoing effort then don't duplicate:
>>https://lore.kernel.org/all/?q=3Ddfn%3Axilinx-xadc.txt
>
> Hello Krzyszof,
>
> Thank you for feedback.
>
> I'm the newbie at Linux kernel developers community,
> and sorry for my mistakes in sending commits.
>

No worries, we've all done it at some point. If you're looking for stuff
to do then the todo in drivers/iio/ was just recently updated. There are
still a handful of drivers also in iio that still need conversions to
guard()().

>
> I'll answer your questions.
> I am not part of any official mentorship program,
> I just decided to try to contribute to the development of the Linux kerne=
l.
> Yes, it's a ongoing effort, and to be honest, this effort is the general
> community initiative to convert all DT bindings from .txt to .yaml. I did=
n't know that work
> on this file was already underway.
>
> Tell me, should I continue working in this case?
>

After looking at the link Krzysztof sent you it looks like it's already
being done, so I'd recommend dropping this one.

--=20
best regards,
max
