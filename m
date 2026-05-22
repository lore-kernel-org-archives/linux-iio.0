Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175F135675C
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779433669; cv=pass; b=Yy4RPde6zVev2G7VKMnnhQN5qQWOJdH+MqFqPEaDI5OHtfhWwZJquidKT2Mp52NS1Ab6+4uLYJnzfqFE+4OUTAo8dDTTb3P5c5M5bgYQmZeSDG0Jh7doPGKm1Vw6BrzsMtb/S5nA0k6erUR5qN+mokdHJM0PepKjEwe+Uhz/Mro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779433669; c=relaxed/simple;
	bh=EPl2BS1iOXffbr6+HzJ7M2qwiGQvNK4J0IVrjdekixI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzbEqKP+tkCSe4DGCUQtZuMSJHt7XLIhvYHY10NHf7jjS4U/LUngNa08uFK2W3AMFmMLezLBGZqhzrMesKt7HHKXKOW0NIkAtb7/XpqV+YZSR9Ro//douD6rfdzVHusufNDILrFfLHn3oid3vZxkbonYaqzRXGBzX/k+uqhJraU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBXdV+cp; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBXdV+cp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490388fd0dbso14003165e9.0
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 00:07:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779433666; cv=none;
        d=google.com; s=arc-20240605;
        b=RiA77/SojghPBNVhcvBv3BeWvs+t2wWejlEWSCzZ3YM4pEtJZqprZ1SMfoIzFhdpGb
         VnJrXTOYn67zjOPMMGsRuFWr/VdytU/hSf1WoS2PhukGbsqmxF0Uu7DxG8ieo5DLVd0H
         u/SB3WiJ7Ng/ErPZX+nG7+AanykXjTpYIRKeRUksaYMDw8fTA+O+AhHbSahh+xORixoL
         3HPfSZIh1XgMVCiptDUBQKL2FXnFjvOeBKGnobex6gH+nKGH+x95Ayg8p4PJIw7GzT7g
         0Kuff4pQ1DilhngGTgRnv8HUCKMTn01BsXhGtbr2iQMAqoqbeHOCjcM++FAAm+q3zMuz
         Rb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MlB1zbZ3SMOheC0AHg1Xca54KX8FSM8S4mSIV4vaGPM=;
        fh=FA4xJEVdr4mduVTOT7fjnBxp3tUg3GUXDHngWTgRfd8=;
        b=F6uHpIe+aQEwOid5sq0sdNglIC0S4Ym3iaUt474CKqYNeUw2p+K/VcaUWOpH+Yw9lz
         TjdupwjsSqvTWfoQzFN45/MLrhVZKc3GqQIL2LgKqNjH9iRrI5hVwresu72MjuQBS1Bm
         tp+hQ+jX3FGnWuLUKlOJHz9b8Q8x09oNHHY8Yi9QOyRQoqWpErASJpdfKIAFJ2wDvSXE
         cM1lmaev5bNvnDwX1Yxy+FkMwspEB3x+42Z+hVuBMxK8eSqiQGNUwNVyys9gBDoe06AO
         iCHEAyTK1OBtSAGOhbh03e84hQNjA/vA1fq5fh7cb40p5CB28siUFCBQqi0M9HWkBRQ0
         rFJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779433666; x=1780038466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MlB1zbZ3SMOheC0AHg1Xca54KX8FSM8S4mSIV4vaGPM=;
        b=BBXdV+cpYxs3FyMWZAizdTK44oJSlnmPaYwxXW1P9AGN4/r8eBKLjl43ho2R+0wrHf
         gg8t9MGDDEG9Uz8mrJzyj7nmPqa0QEJYTpRXWvXZLNJ59L1yWact8tKCIkcauuKsp764
         /i0BtLEEeHoEkKaydqVpLyiq6MQjoi9Dfa3qi3e7MCtWaoobt5xI2e0ce3RwlgzzfS3G
         XNxawi7XjmvuTDC0PrjbqNyyCRzDm6hPfrPpoS4JPyBYNg+7MrnD37nZ9FW7Fi33zTFA
         pvNyIqhg6tgfRsTUI8lc6eWy216E5Fwzk5GvQvbGzQmoahprzYhcicsCdcyQ8GAvv/Dk
         aYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779433666; x=1780038466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlB1zbZ3SMOheC0AHg1Xca54KX8FSM8S4mSIV4vaGPM=;
        b=ipWhCVwRQnl8wKDSOx5l3KwRbUmSpgxBQ6BUuh+kae9RaNzkbi5ZfYBXWw7ERHJgrS
         Ovg7AjscTgoCai5kbVMuRv5zHcywhkmRlOFObCNE0DArbif2PTNeYzFO6PYbmR3MR29f
         pW/8ld0GsVjNSkiscSJevz3aj6AxrcMdJc31wsHEPWr3gcqofzFP6KkiBBhNbSoog6Cf
         y2iVW+OF9ADfCGCyxwA2esl1jviEyd8WD2dyWEyqeivtz/7hjmwHQw33MM7SocFiPGI+
         +WOR1OEfTtZR8BfWb/HTQwoLvLDqlx65yG1FeJjKjnnbhMkxzOXoNnW/KtAj+KYlTtqG
         8gyA==
X-Forwarded-Encrypted: i=1; AFNElJ8flQhjB2VUKyzjkL1hW3PzTPeXRjWGG1pJ2uPgncR9eFhP1ZenvCJqLOnyjnyPIZNs+/Me8dtNCm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsidn6LFEB5yYgJLPtyMKJgNVPFqd04uCsloF50dSxOye7fviL
	4K3xTaAXlJCZMfu2i6XgSAgJO/LdDL3sHrwrZeh2ttvq63dwqcL5eolBlydgZH88zsHZrURBg4Y
	ku5GnLO7TsrgDMw4XwefT0yAkV/ILNFA=
X-Gm-Gg: Acq92OGnTLcgFMA6uUr+tI5QzOO/52/+I52aaEjrqq46BQtGIURhvVxrD+dn5ihMzsB
	kKnMwwcE1/xG9r+16JjgM6isYe7t8vIeKtAkJl1k0wR68G6yA8ZBW2tV64w9nxm8NfOesMWln6A
	dZSUIQye11DncyWdgBCJ4BAG2Zlm2OulHFwoT+x0OFUgznOjoKMUIsYqg3elaNdVZlTcICPcTkc
	Xk+BU+5ddiSDai6C+I76kv3sQgCsADc6PDRDaykoEoUvt6cydqv23D/DLBfjSow2tCZ+oRkj21l
	V+ru4xfqX2ERJYgCXunJE1gPqLh4g2nZ9AI1OKbpptIzRHmPYm+oIwv3qiOlfDzj/lP+gKRMwNj
	poTHo8vBefID80P3POOBs/omSrdOP9JD9wNnmJ7+CsN7+igCU0ZSTUOf24lEVD7EkoKKjnBtWN2
	9M9IQ+jw==
X-Received: by 2002:a05:600d:8450:10b0:48e:82af:d9 with SMTP id
 5b1f17b1804b1-490428cc11dmr18549195e9.29.1779433666259; Fri, 22 May 2026
 00:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521164323.770626-1-liviu.stan@analog.com> <20260521164323.770626-4-liviu.stan@analog.com>
In-Reply-To: <20260521164323.770626-4-liviu.stan@analog.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Fri, 22 May 2026 09:07:36 +0200
X-Gm-Features: AVHnY4KiMKWTphYfQKr03PIgXm-S9q9DlkUTntnpCxXmD3GS3gd8Mwwrwuvcq3k
Message-ID: <CALoEA-yqiD_mEYF4LGuVk9Xf+UJwREgMdrHMj-2U+96TSU7EWQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] iio: temperature: ltc2983: Fix inconsistent
 channel wording in messages
To: Liviu Stan <liviu.stan@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra <flavra@baylibre.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, linux@analog.com, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 May 2026 at 20:16, Liviu Stan <liviu.stan@analog.com> wrote:
>
> Replace occurrences of the abbreviated 'chann' and 'chan' with
> 'channel' in error and debug messages throughout the driver.
> Also changed the diode invalid channel error message from
> "thermistor" to "diode".
>
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>
> ---
> Changes in v3:
> - Dropped both Fixes: tags
> - Removed the "all" from "all occurrences" in the commit message
> - Fixed some missed "chan" / "chann" occurrences
>
>  drivers/iio/temperature/ltc2983.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
