Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6F72ECD3A
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781871018; cv=pass; b=Fbt0CdK/xSpLECzuv2JqhlpysHkcYgsxaAfsq3s2kPd7IjZuUq2dTFllCAGgNPPZtUgotjUO4uAFXgWrcj29MKG2QXQ3oefbGtbYg4V4n/ABfo0nuCkX2MXcpEK8mRDqln/LA2qEWzF/mg7GUH0gUzYneY5pcYjBlZHb+7nMBrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781871018; c=relaxed/simple;
	bh=cjBBihWfju11zOT+nrWbU7OxhbxO+GGb93tCRXN93Cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDV3Bso0+ZnvfNkeQ4pjd6LSPqArN6hQ9jM53BbhtxoSFcfNCmE35nfvh/6GmPvVHldrvjgde7wV9HdgFCiKKBDhhOyW7c6PMXh0xYJvZ5InGyR8A/zT0KRU6MrJ+lIBAuLD4wRwEnF2QCPmQJYukz1Rvg4RG91BYtcXBaYdzXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhXFzc0j; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhXFzc0j"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-660e9ff0587so1264208d50.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 05:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781871016; cv=none;
        d=google.com; s=arc-20240605;
        b=DCUpnge9e/kh9CoYVF423YE1rNPfqPYT38+9EmA/LMaYAFiN7MgBnQYsCZI2B+X+II
         CyTaq5YNTY53TKOSRpb1iX2BDCvOdYvbAFO9aCYC4oGJu4LRUKmwbOuEhu7QAzyth1re
         614YYdDrMdddE0YfzJSx5wuZ15N6Pe3nK1NUobuWizoDY3M98ix9x5C357tdyJRt8gXy
         QdkhGrqroWWLefp4Rov32oS+U1QsfkZaltw2zUblFwrbiqhLMivse2pSgoC4su1EmMqq
         MryNtpwdCa/TshGaCOz8B3X/9QBDCahVSXA21csQbVXpLRqWJPtlXEg5T5whT1RHAUkM
         1yDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cjBBihWfju11zOT+nrWbU7OxhbxO+GGb93tCRXN93Cw=;
        fh=OgxeasCrvz6vIImPQ2j83eYVRxm8UYAAt/0tiIm+RWQ=;
        b=ErU5o2dXg+HLyEo8anIzkVYw0P69zj5SDtBnBeWcISpaIIsxa/p0prQvZbe91PBLGa
         FYqgBUw+Oo2fKxASl6E5X7ebHOuQloYefLzpMTd3XTbIMkFtX1M0j0W/7JZkLoS0TMr5
         Rzo1vJQsZGVRkC9DWGZfiQPZ5DkW7Ynyre1O46nAeqcwrbyt70Wl00OpuifX2K8Wud/7
         POeCVEvwW7kUeSkBxCYaMmFXI8MZ8Fyc8rXAFLSQVnGkpogcepgNSkAKV47K7aSn7yFG
         XUGk4kHSEGxIv6yCrTngzwm9XYSTvnLQVX2gasKY2q0Qc+6iAE6pFKR+m+Q1GwwF2PWg
         y6Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781871016; x=1782475816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cjBBihWfju11zOT+nrWbU7OxhbxO+GGb93tCRXN93Cw=;
        b=DhXFzc0j4chHSitKdqIXAD5TdUehYu53rmQ4ATdGsSzOO1M/1ROnInyibOMnUqiWnb
         VhxpIcs9u3uzey+Wq88VN/8/38jQLIf1mU7yHCxf5YNYxUbZaJX82J3TkaPcfvgRVlzk
         RjicwQqRpz6dnojXVWnZj3ynY2VROTkOzQDCXiXkliVono1Cj3jLV91hxVJSLg+5AzAe
         hc/HJEhOBcLFJwDSwiOahBPqqyZVxvVh8qn9kApowEqj0BtylJDJfDVwx/5dHWSWBS3K
         kvUGoAqkkLp7iU0+MiUyBBE5QZ2SkqqahjrT2RBAn+2kkbaUz7Y1g8VeLIF5HBo9ErI6
         k9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781871016; x=1782475816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjBBihWfju11zOT+nrWbU7OxhbxO+GGb93tCRXN93Cw=;
        b=j+1RgSoTwFih9DCmtobgAwt4DVBKA3VARco1LC6YAI6kXHrdAW5aKKP1jLF9ACYrto
         W6yJ+TYKWrs/znDgCwW2/VzpMI+XK8EWIAb8ROG4J3uR7FeLpn3mLhOsfBI+wZ4qioxM
         vFeGdPl8ywrsbporODcFF+7VpOkbPkFgA2eRlLJVgPq1VCiNfFBs2e81O4pNkqYbv+Tw
         s+mn/vT6UniSZqRv31ZshRuPpAQ3X5KKIpb9uYJE4XnXsvDcP/tylHtarwj0+o7e1BGS
         EYhdlw2UPvNsd2t5iHIugdmAkSD7w/PeGl0SwlnSER1iXL4/dBFetb1QwspDDhajTF3y
         EYSQ==
X-Forwarded-Encrypted: i=1; AFNElJ8JAN6IKYfeJ6Df77l173iKoNS+9X4Hkn4lKkA6Rl4dKEknAVMH7qb4NZaqd8GLOWQYKvLeQi8tQl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLHBzKi76RWknVmt+MLhPHdGG4INKzx2wLTO4lkiTz+dutAnt
	XxiFh4q656NTi9t817yjahnc4FlqfsAGuj1gkPJGBGiNSwwbSE6NdT7om8uXRBNXLPlu9TXvV23
	ZGSzW05BbVUikz9Mdf6i1QzlXfx+2yLY=
X-Gm-Gg: AfdE7ckhrAsTbXpwcbtKptvmIJPIUXoq81KgtgvNUqmobxYLYOK58j+iF+XoVp11LCD
	hgkag8XweX9VAIoVacoEh5jZ9IxRTIvaOIpJqqQvhT4kX4P9p6rj3JOGUPcN0Yu5d+0LpnGeSK3
	6z1uZG/2InUkCWC406gBaMfe6fiwpGfVeRByqUC3dyh2iE3NLj0ZE5Qdo2J6xhhCj1nJcqTTZtT
	Lfl4BpAVvtmKoUeJNC6usoQObd8pXCAbfEBxuL/ezZowh8MCvBSnYOHyUbJzCSyRZiP9Jl07Otn
	kNYIu1TxaoHX+FUoeMPrgZb0pA==
X-Received: by 2002:a05:690e:d48:b0:65c:5b88:84a2 with SMTP id
 956f58d0204a3-662fc5eafd2mr3691864d50.4.1781871015740; Fri, 19 Jun 2026
 05:10:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA3NoopBN5qXGvcBY3M-oxXzez+up3-mXZF2kqtzDmnZ50T3Vw@mail.gmail.com>
 <CAKqfh0E2479wCvQCRq24vB7r6HP7tgy6YKEVF1U0wHF=uchVog@mail.gmail.com>
 <CAA3Nooq9J67DvK1FQr7jmnvTk8LvYRj4m=6+ax1d+xbu1eTq2A@mail.gmail.com> <20260619092052.00002344@gmail.com>
In-Reply-To: <20260619092052.00002344@gmail.com>
From: Mert Seftali <mertsftl@gmail.com>
Date: Fri, 19 Jun 2026 14:10:04 +0200
X-Gm-Features: AVVi8CfliwbEi7nxKuep3ArPX957nVPv4tk4yZmXE98-Rh5S1PfD_fNq_vEHQNM
Message-ID: <CAA3Nooogr9LCPLkH_gBn3UWbeRqXSozsS4Sp_HK4VrJDG4cgeA@mail.gmail.com>
Subject: Re: iio: accel: dmard09: in_accel_scale always returns -EINVAL
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org, jelle@vdwaa.nl, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Joshua,

Thanks for digging into this, their bust explains the missing datasheet.

On the dmard06 sheet, i don't think it carries over though. dmard06 is
a different part as far as i understood: that driver works on an 8-bit
sample with its own scale,
while dmard09 does its own undocumented bit-twiddling on a 16-bit read
(the "<<4 >>7, remove lower
3 bits" dance). Different sample format, and dmard09's resolution isn't
even spelled out in the code, so even with dmard06's range i'd be
guessing dmard09's scale, which is the bit i wanted to avoid.

So unless the real dmard09 numbers turn up, dropping the dead scale
declaration still looks like the honest fix imo. Happy either way once
Jonathan weighs in.


Mert
