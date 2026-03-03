Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B71201278
	for <linux-iio@vger.kernel.org>; Tue,  3 Mar 2026 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772514686; cv=pass; b=o3J1erV8q27XQigEgDvTnznfLoKhsHiqAZh/5Aoldf31M74e5mxiU3mAOc8egYv8xJ7+gDc+ZpBmCCbszDaEOGbK6lFqkyRE1OHJw06hrcJDpN3DpO0+IKbmEgWJFrTOpSB3qLlpnwZWeuuhjwj8hZuCxQLxAsar71BkdRE9Ob4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772514686; c=relaxed/simple;
	bh=9iF3Gzv7Q9ZuqB1rLLn5IS+bE3rE0VogYGkJMSp6g/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pisL4RH0rTns8OX6EJkklW67DYYoou04FlLmEhWwMc0mFglM+szgMYjtqtIdFYneKjNkGJ11j5JuFOZBPN2KzYzk0DvlYREKV7Cg32pQW8kKLS7rTzMz5vIQxnQjEd/KvTeIqPlyAecGhi6lXN3Ev3RvYjJ4D+E/PRFq+/ymCiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIN6dIsS; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIN6dIsS"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ca09f2170so5310854d50.1
        for <linux-iio@vger.kernel.org>; Mon, 02 Mar 2026 21:11:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772514684; cv=none;
        d=google.com; s=arc-20240605;
        b=I14RMBzewSsCysARpN/2WjPejHAwuKysJke57axOfANUzcuqvpKqgSWrECisXAIXtx
         ccoWHd6MBQ5osz1p4bcbDwpY0oKvE5jUxLRWfy1WBiTKlHmmK8DCxXNpq0qfioBV3E8l
         SE8Wu2cZhWnHP0xMj7hUFvKc/IwhbzjyiMpERdSUSe3KMTa6bbCdYvuvwlZj3PligAlK
         uwC5QpgJyoqbO2Zx1gYTMo5oz9jkLcONcSo7AMBXsyuJ/7UlM2o63ie8CimexpNporZL
         ZHoouGd7tSLR9n0xD15gmNdRClcfdj9zaJhYg1BogrQRTQG53mKrS1Le6QcHW58Tr/G7
         DSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=emEGQz5YDfAuOf52ZhPAl4T6Ect0qYTBuPN3Zfy9zzo=;
        fh=+IcEWQq07NFgWW2qjNw68T8Jw/5xgVGCaDfUKKLjH34=;
        b=Wr0oGDgXzZuiZ7NlSjRpLDkdGLWKnAyCHRWiuwnLMM0sP3+0qMFScu1yJibSfw+k2N
         +DVWpbcoGLkbcSiX9sDFzMSOlAfXmGH/Q73zDVmOOcaF55Pci4+eQqy2HVW3StpbOYCv
         RvaYwrRvusBwTpLThXKNevRB/WaJBhAajFAMVLa2suQ5NS0oZ57PefA6XEqw/+QxunH7
         cxNft22neKwsfGviY3QdhPegqG9GtIqE7FqdgvKjalD/gmjbmwEeC6zXX4m/2+EnWbfe
         tUysLxSop9JDD2vGB3zx0S+BULfMw82tTlUUrqru8kbwDQuRspEKYGC8kfhyKAv8YPgH
         AHRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772514684; x=1773119484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emEGQz5YDfAuOf52ZhPAl4T6Ect0qYTBuPN3Zfy9zzo=;
        b=DIN6dIsSttgYC/8XO3kLkigU1eYKQPTgjcUXUqaQ3IaA5P4/F8T/FJcy07J+FMghVk
         QR2/pw2O89Ab/BboJ/Ng+TJnEAKi5Q3snlAo8l+UyKxbtXANnlLeECB7hAe29Ftz6gU5
         7qH4y++8ycjhuAo2MgHW3IEsVPxl1+stksUbNyAJdVR7LPGHFzD7np0BDaMbCXiP7wGU
         hxp2/Z65yQG3ofE7GFx3I2ZNL3V72aOK8rZRQ0ptFMMhlWbedT9xB2ZjZNS21Wsw+mLT
         lTsPRk8VwKUUxWD6MZX7HqaWHhV69yvXcPvDjgye5EzgVSW4Fqwy/9erKBckXsk2m9bC
         SNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772514684; x=1773119484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=emEGQz5YDfAuOf52ZhPAl4T6Ect0qYTBuPN3Zfy9zzo=;
        b=kIiZd2iLd/Vso4EtmNKpOyH6C1vrDorBU3sy9+5/dYaSzcvZkWtdcEVKIY5gNO60mj
         UwB/Ws7G0KwmLnMSbZhv+8el6tvP1sU2jMvo2s9yCYJFj9+qO1BgQn4VTLARc6ugHmUu
         LrRTVX7kXkNug81VTiu7znaQ0crO0AOgafYjftDUlQzhDh7izp6wdRvlAcz8Wh0UzEnN
         GfpVCh7m5CC2+1u4kVR2lf57VKjyHdPWZQFbrpwXwfbDt6bRxdfmPoz0eCOfDcKXoJhA
         7rR5zBwo4dxrRhMq02Powh4c+OFcSgP7hfGMMMWTNSBiu5oPeevIWRcRYFaUA85Pal3J
         x+Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXEhZdYRj04kJ7d3xaQHQvP0K9CELN7GTr6Rpf0ZlOh7Md/hLd2ZDoqtJ8i/P2jmWB7TN5qbRLAsdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3EyPF4MfMYVDvXjOJmXzARQqSbnJYJj5gY5hmPjSegsgrCW57
	o1BZdcEVf6QjQvBBd6t+UWeSsWNiyE+rd0DEWKkkqL4I1Y6HspmpY03DwAR2cWeP0TUqhLQXrNq
	sOqyUjXylm3lZAjErTOtBuilRWpnKejE=
X-Gm-Gg: ATEYQzwZQ1wyuV1z9g3GquoY/z8CFSilIGbr1RLy+L0qJXZVm4+ig6PxXmXwSZrs9zY
	4ZaSw07KB09xFMXWopW6CQiCA0PRau4gph3lWgFYy/jzL7vEBGndMqHwF6v0stURlXOiONOsQiD
	VssOzXtGCqVQ2c/3HTJb9Ia0SAzFt+uUYbbZkeB4LUYZkIZvsOYpJxjGK+SC/bO76vwotqS1IEf
	aCWTSAG028qkvQlu39zQeaZmHHSrAJckaHHFjWHweriKAETZwvVPqPGp2lMDIIbo/fFOWhy4yrf
	K+r5PuTDNA0AOxczR7OAWES9w02EQEpIAxJNzcRSsg==
X-Received: by 2002:a05:690e:1a85:b0:641:f5bc:6945 with SMTP id
 956f58d0204a3-64cc236399amr9865259d50.73.1772514684022; Mon, 02 Mar 2026
 21:11:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302130632.29144-1-architanant5@gmail.com> <8ce6bc3a-c55e-49e4-973e-5f135e2b24ba@baylibre.com>
In-Reply-To: <8ce6bc3a-c55e-49e4-973e-5f135e2b24ba@baylibre.com>
From: Archit Anant <architanant5@gmail.com>
Date: Tue, 3 Mar 2026 10:41:13 +0530
X-Gm-Features: AaiRm52kX5F4Jkd4wPOH7zzpH7JtjEV2TMPpvyzS_nNnyDyHFO4YhqjEG2HZGDk
Message-ID: <CADJHxWDhCi4YJcPWsmDK9e1_pP3XyK=BMgDVbBzijEZdFfCnOA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] iio: adc: ad799x: modernize resource management
To: David Lechner <dlechner@baylibre.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Mon, Mar 2, 2026 at 9:58=E2=80=AFPM David Lechner <dlechner@baylibre.com=
> wrote:
>
> On 3/2/26 7:06 AM, Archit Anant wrote:
> > This series modernizes the ad799x driver by converting all resource
> > management to use the devm_ infrastructure, ultimately allowing for the
> > complete removal of the ad799x_remove() function and simplifying the
> > error paths in probe.
> >
> > This series addresses the feedback from v2, where the changes were
> > squashed into a single patch, by splitting the logical steps into
> > individual, bisectable commits. It also incorporates feedback regarding
> > the safe ordering of regulator disablement and IIO device unregistratio=
n.
> >
> > Changes in v3:
> > - Split the monolithic v2 patch into 4 logical commits as requested by
> >   Andy Shevchenko.
> >
> > Changes in v2:
> > - Incorporated feedback from David Lechner to eliminate dynamic buffer
> >   allocation.
> > - Incorporated feedback from Jonathan Cameron regarding the ordering
> >   hazards of mixing devm and manual teardown, utilizing devm_add_action
> >   and voltage caching.
> >
>
> I just reviewed v2 because I didn't see there was a v3 yet. This is why
> we ask to wait ideally 1 week, but at a few days before sending a new
> revision.

I agree, I should have waited longer before sending the next revision.
After Andy's feedback on v2, I realized that the monolithic patch was
difficult to review and wanted to get the split series out as quickly as
possible to save reviewers' time. However, I see now that sending it too
fast caused a different kind of confusion.

>
> Some of those comment will still apply to v3.

I will wait a few days to collect all feedback on v3 before preparing
and sending v4.
Thanks for the patience and the review!

--=20
Sincerely,
Archit Anant
