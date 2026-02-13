Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8E275AE1
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771013502; cv=none; b=J3a4pU4zr8s6XOaPk/Emv9aPzg6OwjeDujaWRpekbrOd13p2cV4Eah3SphaDpUcxOVwyw7qb9X0m3lYVpu9XErpQpE0qe8Owcp6taHpb1CThU51gMQWFOORikMWPbJxxrSUvL6NznTsBcWxecbx4MBq2tLwi24hHT2DiGEqmcpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771013502; c=relaxed/simple;
	bh=O90a92SqH1BmjD1aaJ6ETYExfh7RC9M0B4cLNeA7IgQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=ixPQhXdL6TknVbmXlzULjOezWsMGDwNd6SiwJJtlOYUj60+M8mHVb549GrNmehCX9LKYRND4cbhVHH5PyuX6JB5UgjcuuC58O0b1QRa367U8j77C3Qod1eXD1VJNik7fB+R24tmiKEmbb7H19xFIZx2ZGgRgFihaWeycntT4VFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkM43fuL; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkM43fuL"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-649df393c04so1231724d50.1
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 12:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771013500; x=1771618300; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O90a92SqH1BmjD1aaJ6ETYExfh7RC9M0B4cLNeA7IgQ=;
        b=QkM43fuLqhgS55p3XodHww76CcJno2ZiHISJGEs77XXyo6v0xpij6DnB1EdKxSVODE
         6VndVRBTIRpdRzyGFFhPxoTna7lOcJjRxj5P4JZs30sdDjjPq1HtG3a2gVcEwPC8WiZQ
         RhVnMNpOJCPgP39H2Td5DFY9q6ejIIjkNVqwr2VKoIadO2A7cktwVXzij0QQAdkVOmMB
         o3WOdaYcOaoxJM8izNnqweaI/7kBi6kegPgrLc+KpONY7vIz1JE27LK1q3l92owdVRMT
         wlB1YbWYuF8U6ShffI/ADLp+Apd63Ze+l/uXd9l9lnJrvVtMDZYr7gaGKjYdTMVKKxTb
         qxZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771013500; x=1771618300;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O90a92SqH1BmjD1aaJ6ETYExfh7RC9M0B4cLNeA7IgQ=;
        b=Q6rn7y95cDeQ3ymNIhxzVs+wsVcJNGSEAaaLGGCpkJcrMQH0NpC3hgMHGCRWR3+P1a
         ZSTMpjqHqHNbZsJ+FxlvCJMEoIxYCqjZCYC7QxSN4dz8dl69nmbm0xebxtM5XpzaLmsV
         ewxiPeksarv4dZmiXQ6ZPZY4piVNNen0H2tj12bKi7PUZ7VcUgcVBZCIHGKVNk4fHPa4
         PrsG2gktGV9ZeWU2YWUR7mPYgBGkKhxBRfUZ4+ulrk3q+tgZj1MEgWuRTd5oHc7mjlru
         TNFdZAOG5S/o8KQzvGtUQ+w8GMpW+xmDlsjvbN+ZLh9QEaUOZIbxKl3wHN5ZFTQxOver
         21gA==
X-Forwarded-Encrypted: i=1; AJvYcCW1MzUyumDjaYO37mX2GJtXl7wk3u795dsNtq2cvovybXhs6FWHQqisgRVnCW0fvGhFpavbJxL5uvg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8nG5YmWeP8tdJZBnNkOXU8KfeZGpAP05cC+y1FQo4TbdoNtU8
	b3Q/YfVvR4Dj5z+bkIuyCQ4D8q4gUM944riJvxDZ1dV5v+fhvPmoaUZ6
X-Gm-Gg: AZuq6aJjgTlI1+stgw10EGwxgTLwDseUNF4513cUoA8BtZCPyIgjbc/yaSvwc0pht4n
	XVxmbRfzsTrmdKFOfUur9iHz1YkQ/oF730Y2/NWtuq9cAL8HuKLD9/lTmcIvPSJipJpyq2WfuDw
	x6k60T6q5nDw3ImFBtl4fD1SamKLKAdvQ8OEj/48Ej5PAZ/x3DJzdkkDc4IFokbiqgR+cbCeVKi
	qUyCKttwCmCiQqI6LMuABbHARsC3QADImKdQgdoOiJTEQMvFE4+6rF4R3X+UnsUv8OxlBevFAyF
	gSluk10VlMI8lBWWt6maxkQ9mecKhueTWvz3/Qy0eLt0hK0RhG693Mjc/VBLWVQQ/cUKu10YXbc
	8e90Cg8rJPgD7/NlryfW3zpkJ7YKKkeOrG7ySRBKNyg46uTisr4mAlil0BQV/GC3zsuMpcRTdtt
	ofQlwBCcWQHyrTAkU9NqTXnzw3BoectQIjXdOolhaZL10AUVeGDFFAF9lbdcVaSbs+pHco04rId
	y2/cmmjtxPUJim/L5KCRHIg+kUfI8uJoFVgjkW7wEYuoGTf4HFMcJbVKd/vAElikE/q5QygWIy5
	nA==
X-Received: by 2002:a05:690e:1518:b0:64a:e070:dd24 with SMTP id 956f58d0204a3-64c198c9583mr2068823d50.26.1771013500406;
        Fri, 13 Feb 2026 12:11:40 -0800 (PST)
Received: from localhost ([2601:7c0:c37c:4c00:c5f0:f0eb:6358:40b6])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc83c201sm7766354d50.3.2026.02.13.12.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 12:11:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 13 Feb 2026 14:11:38 -0600
Message-Id: <DGE3W1MJCPWG.1TZRYY7QD1PNV@gmail.com>
To: "Ethan Tidmore" <ethantidmore06@gmail.com>, "Jonathan Cameron"
 <jic23@kernel.org>, "Jonathan Santos" <Jonathan.Santos@analog.com>
Cc: "Michael Hennerich" <Michael.Hennerich@analog.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "kernel test robot" <lkp@intel.com>, "Dan
 Carpenter" <error27@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7768-1: Fix ERR_PTR dereference in
 ad7768_fill_scale_tbl
From: "Ethan Tidmore" <ethantidmore06@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260213195141.22256-1-ethantidmore06@gmail.com>
In-Reply-To: <20260213195141.22256-1-ethantidmore06@gmail.com>

On Fri Feb 13, 2026 at 1:51 PM CST, Ethan Tidmore wrote:
> The function iio_get_current_scan_type() can return aan error pointer,
> the return value scan_type is not checked for this and immediately
> dereferenced which can cause a kernel panic.
>
> Add check for IS_ERR() and propagate the error back.
>
> Fixes: ff085189cb17 ("iio: adc: ad7768-1: add support for ADAQ776x-1 ADC =
Family")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202602051234.5gArzLyZ-lkp@intel.com/
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---

Sorry, ignore this v2. Just noticed typo "aan" and forgot changelog.
Will send v3 tomorrow with these two things fixed.

Thanks,

ET
