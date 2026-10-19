Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492B4DA9AF
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 10:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792405249; cv=pass; b=IVRtoMNv4ghuzTYGel+nN1kCsWGs1pYODwrt8BJGCP9+uD7Fulqxu+OSqpzDMWlM7jd9MDkke6mhmVbTYDM1GDM9yUMryAUZp2llqSs5O8GWMWqchqW/CS0HRPS4YT3sU//xF4n9qsnk0GV0mF11y94ttsTPhDXqPZ5ZADkBk8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792405249; c=relaxed/simple;
	bh=R9GKKyHyrEzYJ8lOebrsrQB5EWDn1ZlGynlJDG0M8VY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2+3SUDduGHhKpiEG9R3VjcQCGVGzESyOHfRrfyUqWFY7bAJad5+fzgYnaCUtkdNoXOPTa2Ng+s4ZZ8I4yv1ryrswV7vb2uxO4itNj7LQ468xdx1D12tiAUWayUhbgpOPEaEfO+LmuCXNNRq/Id2jNEl+/Yr8AlnQ01qBmFtmKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lk7p0PwW; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lk7p0PwW"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-48e9476e26aso487496fac.3
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 03:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792405247; cv=none;
        d=google.com; s=arc-20260327;
        b=UnCbz99FsshGVREofm5q1SQj45AGRaVNe7lCSy3+AduzzmEz5CJ/XN5DwNBygNJHMm
         /snsBeTtEiP1hxI9r1TNN4nWOsxmn/hRffbT7tR+i1MOq6ldTZ+vF38FvQYjXhaEi3Va
         9PREyf6oMEkycWt5pyMj+CUu0xJOGTKpQD55RS4evYq7y9iB5DDmDGDyN9a6R2trEKnP
         MaaguXOHZXUzfMMHFgTG5xUpPJ77lczTfdmylR2zyT0oOPgmBQxpyUAyz2sAaS+wW9eN
         wyqLolE9fHbapljNA6tla7V2tkqbvM1NFuwn0deYe4otpz/hQa0cLD6BgtRbqSGT0LvD
         +0gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=R9GKKyHyrEzYJ8lOebrsrQB5EWDn1ZlGynlJDG0M8VY=;
        fh=Q7mwWKJF5DdCM9WzxauuZEoyIDmiH4jhhdUFfD3kUio=;
        b=OKeGS2q8TJHgGsYZ0ulf063AWKgyxvLUC5X8oNLvkFKWwGwvncRdp03MMEgQkF71fc
         p+PJorT5nO3hcEBI1htw54wg26rN+WknhhGeks0Uj/Kqt40/QySA1o2R9R3qTNChxXE1
         EEDpRglt/w5jKlT+lVNKIkfTDLlnD//GQ8IbMHbeC100/aothMuzLAqfXyo18X8izwMX
         aW1lgdvEQYcutMUZQ6R/AeE2HHEFANhlCAkgfRd5pzYyJLfj4FvW/SyBRnt9X1oPYbaw
         Xy9yYfeaK0Q2UHHLVZb6QWVFmyyPbGclSQp2ZjYEkQ8W2Ehs/04j/R4YUCXgIQLqYh+J
         7Qpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792405247; x=1793010047; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9GKKyHyrEzYJ8lOebrsrQB5EWDn1ZlGynlJDG0M8VY=;
        b=Lk7p0PwWsY0/aBbpzkmJDgOihuRjPSpon03h1M/0uRq9TvxUrfve2r9IugLM8XrBOV
         YMR80n+DMTTB+Kipotcp3ynb1KxCho9IYNTUsI3F5BbbtrAjLzng2SUYHe4QMXpPTXtw
         nTS8daJioIDDf6Yb0GYxqOB7BRmj5woEKKCdhhhnUiYpwkVkrEkQU8NEvRBXfZ0yIQ0Y
         aDNskbjbCYHg0P01oYeHKbG+srWV9bjf9qLLa5ywqc58pcxkm4Jz7Mcq3sAjJPOK5LQq
         giaGBHS12XNxb1i/qkhm5Yhhc9P54ZlVSpIbNn7lwtmLP1Gl1MHZZ7grp/RoYKk5+IPe
         U0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792405247; x=1793010047;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=R9GKKyHyrEzYJ8lOebrsrQB5EWDn1ZlGynlJDG0M8VY=;
        b=QvvOZXxM0WhHq24tMW1r7BKYJ2JGEfg3EBor77oPQHGFJ8t/1b5IW3RuWXrNK/f3TL
         SQMZHAf6/e1PueGaUTbeVXidCxRsHsJfI8LRl0PRfshApchBWSkDwr5UGEZXuTWoHHZq
         aZEpfG3ZGy4hKd1GU3DiZMmM7sT8HGx4CUJ9mCGk1cehx+XAypygabV/u5JNZfTS62jf
         RFbMX3Z6Q3YpmFuaxXNOPJ7zGaoO2s8rblkExc29HXbTebioiqINVyvFvszKBF6zR+VA
         3BQk9x3kfYFDPIc1hv9SXv0SPwKZFvkg5kAF/tYzywC6BDmBckhmZVZ6goPqlvtcFfcS
         i7ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxY8UllWPzPYYFFK6iyS/co7ea0hxxRJFldhV2RiXRNbgVysTzU4azQOAdJatDakgi59w+aJP9U3J0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtxprGT7EYh1LFlQUSGbVMNhEXCIsMbuEGmW4rO4xOmNb7E132
	hGSadE9IAIbYOj1i1dD4IuRAs15xkRWUnMkqzZ7V59h05Z9inbXRHOvm191iUfspd1F77Clt9jV
	YaOzARQR9E2SMfFmw5StJeV2T1kRNhjU=
X-Gm-Gg: AYBFou22wRyzrgSFd0lat1nDdp6kzOf9fCMzSmGb2M4Ys8+H/WNjUMuLqBrW6zugJaf
	bMh4l5XX13WwJmtJQuUywMixTSigLmOz1FgrRGCdwDCQMR/R5uCPhf3axcCCgPe+VjaF3rlwkhT
	A9cMJVYTEC5LBogZ6ZbZ74OtQBBCFOJ3zs9akqUHslUBV3w5EBbFXqf5CPtiJMzFOaV2cjRxTKg
	4jDOHBD/sbdkPEwudNOUnNcqvLVHzWkr8hwS75c9YQAhcmUBFDjxeXw38HN9zwyPo8tc1BVeJuR
	na+Jh2l31fmgIZSE/1hAiqmM6LwyGQSYz5R2OGM7004bBDcdd52jzLjqRw==
X-Received: by 2002:a05:6871:54b:b0:49e:402e:68c5 with SMTP id
 586e51a60fabf-4a757beacd3mr6077913fac.59.1792405246754; Mon, 19 Oct 2026
 03:20:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018143108.14750-1-abdelnasserhussein11@gmail.com>
 <20261019040919.0381d31f@jic23-hlaptop> <atXkD3WIgaeamrh9@ashevche-desk.local>
In-Reply-To: <atXkD3WIgaeamrh9@ashevche-desk.local>
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Date: Mon, 19 Oct 2026 13:20:35 +0300
X-Gm-Features: AclHuK_ug4XLdkqieHOH7DEcJfHZ7qFB7S3j8b3XoXuD1UpBYHVkyu4T6Ha4JrA
Message-ID: <CANpqX3Y8Cf+ogOBeL9A+qMuHRbaAQ5Bvegt7SgkWd6pay3h0Cw@mail.gmail.com>
Subject: Re: [PATCH v4] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org, 
	linux@analog.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Ok, I will do it. But let me check with Jonathan first since he
already applied the patch, just to avoid any confusion.

Best regards,
Abdelnasser
