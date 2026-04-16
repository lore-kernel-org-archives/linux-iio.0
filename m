Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B9E352C2C
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330335; cv=pass; b=HiX/MzHJiTMSscB3su6S33mlUxEBDlqC8lgop99mXjllXnCdST4BI35xM42aOhGVqTcsAGrWhS26U9erNm4Veavmr2KtlOHwCXP41KlI1RLUN8EcSr8brnvX53pzCvVzxGv1qR18fh7dzREHz3gN/L36uQDOz0t2JzbsyZdXyg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330335; c=relaxed/simple;
	bh=WbU1UspY2qHBDo4XKXSrqD5VY1+388leVHWxtsN8UvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r4o9csXU5vAoSOFZ4bhnOefxTNXexEfQfl3wJazIxOpKFNiBqFLTuAQddXvaz1lwzmOLQ0SgvpJCjEnCoOefdWOgeqpFgEeOxS4iDly5xCpb//CZ8qjokkWeRgB5ZlSObEU6A5kj70fO+VpSOUPx+ZXrkVhz6J5aaL6jfvAw2ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQlb0Thh; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQlb0Thh"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso42916465e9.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 02:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776330332; cv=none;
        d=google.com; s=arc-20240605;
        b=GXrf7qC0urnr7ujRslzQIWZRfgCv3Ok6ahBH4EbDrJZBepBp+eGKxrdSEYToeA5SmA
         Q5Zo2IpzsiLdKU86Qk3p9+fcCGPP8esmD+vk7hTYWQFofAOIQreJrnCJrtSAzC1jj17x
         0LVudQHH+loeoOjl7m4vmL94OzuOR3w6SoR/SuB8aB6jbmaDw0uEZG9046he4PzOtrbS
         LsJhRDZtwKBiVQnsVG68s2jqSks39AdtpDNppfOvsaq1dMmG/H4ic0YTnORq1oKDG652
         VDTHMFdwNfTrqrCjPXTtKzSPFYciPX7qmuOS6Ez2XrhgT0O4FCOHycNqbBQkgnSXAx75
         QfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3xMM5cCIqeLaFYivVgDzMsFxL5LiXfHO6V/AM5SAkU4=;
        fh=HIOQEOU2JhNHXjTxxo23SzlYr1Y+i2G4o/YzHSFCbm0=;
        b=DHLutOSXGXLIcugfYPfJSuw9SxGcbjOTH72qK8osUuvWqCtnLAr/kiPlv+oAqDOR5a
         Aqu07Uko+tjx2mAabyBsQErmvD8gLw+J197vOMwxuNWKOfSr7a1y6K0SPvcOxzx86N8S
         WV+Z1uF8gXE5OLvOGHU2VJ+3pXckaLPRAAIujmGoTbFSIFjWO4upWCnJFjorQL9++d6F
         x7CqoXr1h4j0X3px55LiSEgAsx9lVLUAsF9CkDooYNoYPwsOgOB0UwIOUQ5o3xhVE0fO
         IsHS/iBqRhsGTgN+eVGs4Qf16ap4XnM0Y8BWRImEtJmKMyq70gqh22KVy5q+9fg0/SgY
         nSvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776330332; x=1776935132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3xMM5cCIqeLaFYivVgDzMsFxL5LiXfHO6V/AM5SAkU4=;
        b=JQlb0Thhs+i/jKWn+37FDAKnXQ/SiwZb2r1wiYwjxnvsRMg9nwJ2zrujvX6vUt+DY1
         qqmgP4yWJG7hhzpr25cYQhyGow8RDI/oH8dnZ8CWWfds9QZkaAiM/YZGTR0/wJGUirmZ
         47OrDuweTngUKlMzL1hrG1bhUKyGDPtzMZZSQIiYyPinBKfITULU+i5aycQ1U7jjRgJh
         t48/yEfysDwiL7gsuKx6FiydPNairwlj/8d5U8U4nj2t1jcFmAvmXFbxM/TOTnYkbydF
         /SdgkJbEGQOK98Q8262m7Vsti92Dqsf9T0t7ten3QY8DyX3KhIX3LbOb5jtpxZ71M9IO
         +XbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776330332; x=1776935132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xMM5cCIqeLaFYivVgDzMsFxL5LiXfHO6V/AM5SAkU4=;
        b=EcpkDxyPixg9q7dOiU4bZcPfixyxbBqY99pfqX4tmiFeO1Yurw4IF8HCZIGZUPoLTq
         eyGQ777NN+gH0t9VpfqcdQQT91U5CDQ9n3U8ivYJuMH+2iIsraGOHd+7IB2hld/oCuXV
         zt9xwDC8MPISno6bWJEJ8viUXCUOfJsFCT78g6pgmPQ6gPxSAX7f9x6quI9ObXjCQ8YN
         C56TrLNeXu8rKNkPC9SEhMY1YZjQbXOFLM+MtwU/ZbcB46md4Glg451sCjQZxgegJYC8
         xBdK2j/djxnvqV2UvSjX/lO67VpeymZn/Zarome0K69RefvEx0y6H5kObqTCnbROcdBn
         ikzw==
X-Forwarded-Encrypted: i=1; AFNElJ9uUp20oDuzw26fRIg66wHlZBTcmh/69uXo87ogTth1ciKNn9x9yNfnCsIzAZfXd704a+NXRzBqG40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5h9eoQg4utK2ey3pxtaAk/HhDncLWt822jB9OGK3CDZYRV0MP
	/syh80vLpF6ZU7k7uXmmka0ZsiJkV0YxHKR4XrCAyUls0FXDtKqZmcPPFQqwPpYKltaRr5C3yKK
	DBdEwaf1xvSsyEayjpouuim4e6kayzByEgCieBiY=
X-Gm-Gg: AeBDieuwatTwlTRpxBkw+4sXtwfJNxmZhx0p/f53GI+uYrO/bFwj1rbu+pn0Do9o5J1
	N82h9iSjJc0+DMUPQoIDdxNzfusM25fmM8m7UmWdEbTjgMWVcoxZuvu+VYe4ckeEJOGfDJDNhWS
	XUPNUAw5rjKV1dRVJuqvajs0j31zQvGKfnglxM7+9DwmgRPCNSV//V/oxFWKaQ3J+8mxwqMfGrz
	eLwWogLiZzGgtqZwEIN4HfCNi+d7MTeFBcop7IR9/NacNJoBt9Lb/Pa4i+duaygHIRuW86hUfFI
	arx37RXVHrHNZw6GpxkEYfYzfheOqJEkxKUjehqjcrA0rxQ9F7w8/V4MB5VT5BcMU+Z7vXpKiJu
	B5xbL2bGMt/n7UGa3ZiWsfunLcoB54DFLVuNbQXYhy4fRJpYVGobs9iJCdLtY++BY1si4VUa5qH
	aKHP1+yo2q3Y/6z4r+
X-Received: by 2002:a05:600c:3b24:b0:480:2521:4d92 with SMTP id
 5b1f17b1804b1-488d687adb3mr361516645e9.24.1776330331981; Thu, 16 Apr 2026
 02:05:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415112030.1324-1-joshua.crofts1@gmail.com> <ad-iqJxCoZ18nESz@ashevche-desk.local>
In-Reply-To: <ad-iqJxCoZ18nESz@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 16 Apr 2026 11:05:21 +0200
X-Gm-Features: AQROBzCT-7Exk85T9eopi54doEw_iY9TL0LQF2j7MT8rKpu6-vLdOhY9qC0rKo0
Message-ID: <CALoEA-yHcXhM=zNtZa_x=VuAzGCbLD8QCHPGXA1GFYHG+0ZtOQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: frequency: ad9834: clean up includes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 16:37, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Still missing types.h, math.h, and probably more...

I don't get why I should include a math header (I presume you meant
something like linux/math64.h), since we're only using do_div(),
which is a macro from asm/div64.h (which linux/math64.h includes).
Last time I came up with this, you recommended working on this in
another patch.

-- 
Kind regards

CJD
