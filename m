Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865992C1788
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 16:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604289; cv=pass; b=P401TZHdvhCX7vEfZNlp5zPIsiVvsJnQZhYqMcG5NVFtxDjsL67rPXusU68Uj4S/UTPrgs1btN7vgg9YSW+Rmi3LLhNDi+N7bzd8URjHeHsoGKrk/gspfDj5XQ3tQg8FkyFVnxOHR4GsSrAVgOa3yPaB11o7Fw7bcoDoVe3C6RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604289; c=relaxed/simple;
	bh=K6EwhBYgR8WREX71C7289RCShC9p/K05c7wVnAzzM+4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RfrL6f6qfV+q2SYiDK+piTA94eqB7w29GRQgWochOqVKrjz7PMWhZLVDYm0pfuYy0I1753YDZgcIf5cuStGT8w3dLibQjXQp/2gijfDHJpcSkOp034g2gbVKRfbXSKdaih6WLQ9EWqZRRJW3LomfPXyQSxUSDsMaT/kQF56u/6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0C2vyPt; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0C2vyPt"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2ee1054627bso4846372eec.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 09:44:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778604288; cv=none;
        d=google.com; s=arc-20240605;
        b=U4noBmzvACOZpf04VgfDO8gfyNpWtLDGyiPaSwpzUxLWnB1WxmVDl3U/NHJs1xHaPS
         nbl30IdxuT8NlltRqS0gIacF3vyLCr7XIv82U6kmhPyEM2vV30u7lWWj1W2/0Ek58Jv4
         6IsF5/V/IxLh4Bl4U2m91Z0CVV1G/5XpUmo0FRediux02lYqfBDf8GXSb6tApjIEt6Vq
         bvMo/DP3/lSjckmsjfJwvdesRCQvZSU46ffsvT7rVV1VmYw9K4SqXfXaBE9ro133Iz/l
         bO6VBV9eg+9Tu+jTb1JnhacdyZ9jVo+fvmYwqIuckOh2LodpfzolqvYpnhLEI13hDOro
         sGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KE98TqSBxX5Jt7KSWTUV2v7V5IAS8/o4Rankgx3Gkes=;
        fh=sIV5Dy9/sOJNezvPr/w1wqHZwGFYZD/n/SbCwfRFnC8=;
        b=GvxwDMvP9zadO250xvpLRMM9H2fzPBt40l6aVetckCkRzi8kYZmSPhS6mM3SGF7af/
         fPj8GQfeXUz0iDlOxscxzlNO66kAdRsJTe9iPOm+feBt6P2pRMHOU027DptZshu7cDlO
         tFTZI6OkIY4dXKa80bREyYqlnEjRhJptEQ0i0COcgPbwEpxVe+CMDVidtTQwO1PHb6M6
         mZzqAI3/mAy1L5vRRE0mWIrWvT03117hCOxuWidi7kKCWRaVrs9zi1wJkVlRcuXUkVEH
         ljLdIiXuJzn88pLJLSPVo60pj7mxJ0rmURWhFUZv3+x24qJZmBVLJNxxxZ9DsisjwgJM
         ppQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604288; x=1779209088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KE98TqSBxX5Jt7KSWTUV2v7V5IAS8/o4Rankgx3Gkes=;
        b=T0C2vyPtmBDZz1CwbXmfil97CioW4CdwFWqfK1cBlop3Wl9nrd9I5nCKpBsTw5ej++
         mnk19p3RLoXLY2B4eSiD7WDKecEdWVoVyRqOfiyi4YHMjuHXRNHDtOookVIlHU/lSas8
         ZzaWkKDTZSpZL1ZQsA5CAhnRPepnneamxv11bMoq/rTyEA6QMChDhnyvEVjHIbIGk+CF
         mVL/HTV647ldjpxGwQT0TcvymSw9YGhfYoGCJ1M1mSSfMZHnZake8b0T1svU7mHd2Zw5
         2ebxh9x5G2JesQhjHGIj/f7kdVArbUSgV8mt4zRdPQQIFhuryiHG4zlS0QOUA5Klwie/
         5jZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604288; x=1779209088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KE98TqSBxX5Jt7KSWTUV2v7V5IAS8/o4Rankgx3Gkes=;
        b=d/B2Aku9kTEJkS3kd12VGnU9r4+hA42L44A9IYPKRNqy+9ZlsJUAF+wagVN9n7t1jw
         tFDZBQRRRc/ou8TRPeVNSb3Y5A5zAcHtBhXWpb9xq82cjTjXETg67ZJHqzYuBEFNt+Z/
         oymYhvZluQHrXqbjWLs9RhiZmqH2sBp3wstBNvGCZanSmv66+cc2A0Z8oH48Q/wcB0NX
         pMdNp2XTEoL9qbsyHWHXSGU00k1n4TAbL8l8VqB0ny89lAMa/zJK08IMp09QZoqItTPU
         m34/5DYE0bpXj6rqupSVsfqEm7tqlm+CA6xISYQ8bTvzZWRmVnE/p+/jeKrs4hG0DPp+
         VYoA==
X-Forwarded-Encrypted: i=1; AFNElJ/1QLNm3b+dwfMkaZNWNGjOByaXXcmFmE6LO9ztPzSuKwQD/4nxC2IJOo+ESt9vZLbPeFmoWN+EAHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOBEf+rMjYXeZiim7xEOLt4qX1SbVgZebulokIKFzk2mcvh77Y
	f4wAU//NOgqbJvOgyUKGntW5JMTTVQDgAp1SGiL94J12DDTS+5nzI9/gCsHc4GvpkKs1hf9ULC6
	a9Rm4YzuJjgMi8sAcXzJ55S4jzTT9YkM=
X-Gm-Gg: Acq92OHzn2HXvFuwHeEHmYqjFYy1EPdsji6sUVaXTat2KYQYrLrRqqHvHPZVRlfK0ZE
	ceZrlRRds+EnZHxOwzXqCwrfy0eG2XiHYiYDsQ1p4JBDroAs+lBdFyZNJdlVD8sf/pHYG9EeJu3
	O4zjmZZLJszUOjzIb6oc28TB6fvZwGNPM0Wa5G2rzNPN37f2zAvtBJAZCAF3nzml/tpocb9uAsD
	ee3K+u9LlCe41kO9vmd5clwubUV5Y4146zDLKSRZwvmUEukiAVq1+iiA0N1vCMOhHUvuWrnkUpx
	IkSp8Jdi
X-Received: by 2002:a05:7300:503:b0:2ed:e16:6b38 with SMTP id
 5a478bee46e88-2ff944e99b9mr2499775eec.16.1778604287204; Tue, 12 May 2026
 09:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511171255.9668-1-abinashsinghlalotra@gmail.com> <20260512150846.76f896a7@jic23-huawei>
In-Reply-To: <20260512150846.76f896a7@jic23-huawei>
From: Abinash Singh <abinashsinghlalotra@gmail.com>
Date: Tue, 12 May 2026 22:14:34 +0530
X-Gm-Features: AVHnY4IgZXPWJF00K01R5LMvN5_zrc3SvwalKeQUzotOXkiT2RgTCJ5QeEP2vUI
Message-ID: <CAMV7Lq7NqxO5cpy7zSrawBORWgtEhm2QTTgRtLptV9==yCs+wg@mail.gmail.com>
Subject: Re: [PATCH] staging: Documentation: dds: replace frequencyY with frequency
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Abinash Singh <abinashlalotra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan

On Tue, May 12, 2026 at 7:38=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Mon, 11 May 2026 22:42:55 +0530
> Abinash Singh <abinashsinghlalotra@gmail.com> wrote:
>
> > From: Abinash Singh <abinashlalotra@gmail.com>
> >
> > The documented frequencyY attribute naming is implementation
> > specific and differs from common IIO sysfs attribute
> > conventions.
> >
> > Replace the non-standard frequencyY attribute documentation with
> > out_altvoltageX_frequency and document tuning word selection
> > through out_altvoltageX_frequencysymbol
> >
> > This makes the documented ABI naming consistent with standard
> > IIO sysfs attribute conventions and clarifies how tuning word
> > registers are selected and programmed.
> >
>
> Hmm. So some history on why it was done like this (long time back
> but I think I recall the basic argument).
>
> Consider the programming you need to set up FSK on a channel and
> the fact that someone is recieving the result.
>
> When you set the symbol to program it that channel will begin
> outputting the voltage. That means someone at the other end starts
> decoding it.
>
> Hence we normally expect to set a frequency 'before' changing the
> symbol.  Hence the per symbol files.
>
> There might be a valid way to set them up using your proposed
> interface but I'm not currently understanding what it is.

I think I misunderstood the purpose of
out_altvoltageX_frequencysymbol.

I initially thought it was used to select which tuning word register
to write into, whereas it actually selects the active output tuning
word. That explains why my proposed interface was confusing.

The ordering requirement you described for FSK setup makes sense now.
With separate frequency0/frequency1 files, userspace can configure both
tuning words before switching the active symbol.

>
> We went through the same dance with the more complex DDS that
> Rodrigo is working on. Take a look at the multichannel approach
> he is using.  It may apply here - I'm not sure.
>

With my approach we can have a new entry  /out_altvoltageX_frequencySelect
which can act as a mux to write into FREQ0 and FREQ1 register
via  /out_altvoltage_frequency.

I will take a look at Rodrigo's multichannel DDS approach before
proposing any ABI changes further. It would be helpful if you could
share links to the relevant discussion or patches.

>
> >
> > Signed-off-by: Abinash Singh <abinashlalotra@gmail.com>
> > ---
> >
> > The out_altvoltageX_frequencysymbol and
> > out_altvoltageX_frequency_scale attributes can be added
> > through extended channel attributes (.ext_info in channel_spec struct o=
f IIO)
> >
> > Feedback on this approach would be appreciated, and if
> > there is some other way in your mind. I would like to
> > work on that.
> >
> > I am also interested in working on the sysfs-bus-iio-dds
> > documentation and the ad9834 driver. I recently bought an
> > AD9833 IC for experimentation and testing.
> >
> Excellent!
>
> Thanks,
>
> Jonathan
>
> > Thanks


And do we need to really work on this documentation in order to work on ad9=
834.c
What else can be done in ad9834.c apart from this naming.??

Thanks

Abinash Singh
