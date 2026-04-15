Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14500330D2A
	for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776249178; cv=pass; b=dwEMXaPHwXApzyU4Fl2w+POfdt7bZziQMUmI8Esug3vKB/5nqyFVRMyKFQ7ruRhDp5sSfzdPa15nyuYsvbPcRM679FQnTPA9bCExLuyRl8K7vJajnV0Z3FTLP4t/4eHLiwE9LiiUT9xiRNaMgDQ/9LqGsPaX8kw6A5vEIKorv9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776249178; c=relaxed/simple;
	bh=gcUlsEe1M4tzNlnYTIpyjWlGZA4y5WzBESrSumGsR1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JYxf6GCMbzguN6PsmuBL+LRLnFbbDeNVyXzJ57VlIQm2+WkjnlbwYc/JfOfB2enV7tGAq3zR7exUB6UKjPb/+gNyDXhLu99v/HTvmc5V3nCU+f/BBingRFAMLAS/8VyjNiGc4KwG6EX4CtCBkX4Dd3lFSqXxHKJVJrFAimJH9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoZbMaRB; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoZbMaRB"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d03db7f87so4124584f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 03:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776249175; cv=none;
        d=google.com; s=arc-20240605;
        b=BliJ4zALpB2Qh4e+sVl8+aG/SlVPXuuDVagSxDmVL6XrkwHUkOsQh68tQTbG/UW353
         p8C7IYmrJU5yapwsDuAa+7MdZ694/1esaJrWEj+UWnOrARrHEXb4V8EaNo/sAH418kLN
         Dqw8UlPmiVZOio51v+F8ElQd2O70X5zRwFm6S8NsQAtLm2HBrCuFcm3LxiWa++Ni4Dro
         8VhSgYDdvkdmjrNmPxI5LLF/IpH2VnoKZmrDgpIYy9ZmKnxevYmPh+0Y4WGGPb+oc8rL
         UPzyFlC4yOnMkoQU30L1oh9LH5/rgOCXW+gKfLO6ZZ4pjnD5N/bjaqduHMPrFuLJP61y
         M8VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=9wg0fKScsyEBn6qNWWO0CXKsqKDKHGGyC5rF436bmzM=;
        fh=JSj6Q+7ute427Mls0hYsL2ilxCzzG+r1k6uMKM9RguA=;
        b=IbkeMTgKAG0yBdsnvmJpX05YvcYhch2FsO+yBZv6Mf6OvzPoACUvfavu6+tMd+Ne/x
         +bxFXePwiIylqyBZ65+ENQpGABCSJgJB0KJ5DB1eL1PFKWZ9Xgu3QeDaw3wSRh7rl9Qi
         dYv3jKtA1ELnXcyBXcD7JeyJmp05LU7doai0tBujivR7qWgXbv582LZ8/Pr7UQeqVFAT
         akQlFnyWosIeZTFk21XxhyFhkS0fMDxXTj4OFRmZohGOXLN3F/eE902xBDgMW+CMQJtg
         Yr3nc/PWR5CWWJyI2RskDEKRz+QSfpBTVrL6pNpGJvZ9kRAWU5Mf0tCYidnIZelDUql2
         3TgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776249175; x=1776853975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9wg0fKScsyEBn6qNWWO0CXKsqKDKHGGyC5rF436bmzM=;
        b=VoZbMaRBAEbvGfRIpbTMpu3Q6W7u3qHPDjKznP7c6qqTu2c/H9JeNIa2OL8EjtUVUc
         yJZobvwPH21Rin5GbMbyZdCAc5LvoLtbvS0TPJV0gnA0akJG42A8h9h69JP4gTna3bc0
         1TInh/NG0u3To+6Qe/w0v9SB4Qu2dYXAT1+gspGb38qQGDf6RSllaEmjUhgyGK88rWEt
         8dFVaKIMJp0S2VwcYIv7xZC7zbwCQp2cyyUYAtbMbzgux96f4XK5PqP+IbByGTFndMXw
         9zw9QDQh58AtgkjDLIxtSpDNKgI/K3y2c0Iw5BqeVYhXlbOBCDkcTfHX7hj5zp4u1R0Y
         6qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776249175; x=1776853975;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wg0fKScsyEBn6qNWWO0CXKsqKDKHGGyC5rF436bmzM=;
        b=XpiJaeAnn3i9IwjZ3Y6CX8Xqz+uBGxDABY/c8zc5KiZyaHp3/uriU/EtpnAUpxr3U8
         L++1aBkehCK0+7trXtaCxT3qpRNs4cM5z0myRdQrVVdYJPdmr/aQhoAdfZC3QJc1Bzq8
         9o+gCSa9c6aUSe0vo96v2kghOwILBd5qRO44Ote5Jzgs7GTui6A2T1YX8LEtgTqkf9um
         YND6k28QWzButR++DoxRWbtNqNxoLkZuwAO6arZ+NcJkwC1yvGH/RvCgA7EQMxtaCwyF
         ecSOjzWE0Mor6Oh7DVb65mcIoQFOzUAF11aD6f/saSugSGoGoLlsPPNmpHXjrFfvhP74
         54GA==
X-Forwarded-Encrypted: i=1; AFNElJ8SgdkKTGMtmgMjbEv0SMhcIEF+QpQaa20vhpcSWZaYdeCy/4qjm84aQIZxVvkKhW46S5Nd90TQQ7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjNB2XXbCu/c6UlEFaYALaKtRBjovuiptD89O2X4y5baeF25u/
	O0kwmZmfm6sWJCLYD3Fcq2Gly1pdOzLs2RZQuDiOjKUm3V+qD2vlJlh1nd1h0tMd9W7Z270MogL
	YrD8vDW3ycbGC/cjHRqyPPqhodUeLOJA=
X-Gm-Gg: AeBDievG8613njc97VDUaSKtVSSSKlwctthmiLeEFOecZ5XTYbPkJGSnnsb7ld8/grd
	VYJYpMl9HQjrBHazTDPbJkeVF11dnV19cDenUG1Ndwqoxpbe3UopFmrX1F7AUW3coW420z9eG87
	FF5ctXn05KKow4DmBYQHfPiiTbOHvHP4IFyRgR0cxOkvzcKfYRCZFPmXT3CIY2MEsHqDZ26o8kX
	GiP1lI1W0iCG9maym4M6iBYl4DQqo9A3aw5Q03e7Pgs0Pv691pvGe66nV10rZD9tJMjM7DkZ9QK
	bgjwk458pSjEo0omHGffHZ1yRcWuWPJceBeMw0xjroj+Ao/8RTXWU9S0umrpDmDV6WRgRDej+ha
	abzWwCPwhKUGZnb0lhlTTn2tBapUsYhS76ZQdiEEv6aTkNdVNkO9fVt/NH1twmCOFuTfagWRlKZ
	x1i/UttdEqpKYi6fJ9
X-Received: by 2002:adf:e10f:0:b0:43d:6fce:3e7 with SMTP id
 ffacd0b85a97d-43d6fce05aemr16298060f8f.3.1776249175359; Wed, 15 Apr 2026
 03:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-2-joshua.crofts1@gmail.com> <ad9SzwJDwRNldv_z@ashevche-desk.local>
 <CALoEA-xy6WApV+ZUavnEipTKiAezYkXMwiE++TjtHuxkVdR1mw@mail.gmail.com>
 <ad9jThxf6PINFFmo@ashevche-desk.local> <ad9jtH1YgA6N6FYg@ashevche-desk.local>
 <CALoEA-xopdHNGtBJQk1_cZZ823qu1_8EM5GR2tB+RdYyuWpWEg@mail.gmail.com> <ad9moW8lYDuOf77B@ashevche-desk.local>
In-Reply-To: <ad9moW8lYDuOf77B@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 15 Apr 2026 12:32:54 +0200
X-Gm-Features: AQROBzAgpxF5G8IgFGjxZKbl2u3PYui6wKyUQ6Gospib9V0hi49nEmhGE3PiYAs
Message-ID: <CALoEA-zSX6hF2nxx696CkyrxCuNRjH9BaB-J1NfyQgs4ZpC4ag@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	gregkh@linuxfoundation.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 12:21, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> Yes, please. And don't forget to carry on the given tag.

Okay, will do tomorrow.

-- 
Kind regards

CJD
