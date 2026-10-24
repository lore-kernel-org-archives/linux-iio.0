Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792810239;
	b=Ec57EB6Jt2jvPFeSiXLtnw760C867MWeKuo92qKwAXXYm/VBXMigCDK+NJi8wWghZFsB
	 yEHf3/K+YUFtvJ1LruF7AY2Pl+8aBiqs4fv3XjIlP7fnn7lLExefvzW5V2vVMbtYxH7pF
	 yWHzkhHzyVpdk8tbivK7hFgwIT4K2xp8zRHYgN6pcRkugfs6pp5JUrc8NvIcyfwD/IzpF
	 pPyB4m8lzENfiFHce33raotZ6WoH/177vELRsxQIbrpWOOtp4T9A+df6U/9NTwzMaVxLv
	 s4XTqBkJDtZI3b+cTnLbscpCRmQ3g05j2TXhEd5K8ZhfdeYschTQB25PnV3SjiS3vAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792810239;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=hVqnuNQZecL5SQtqAHxblwfV/eGlbMOxF3qO66kX7X8=;
	b=IieD/GV8dIcqMPi3mBDUPhlrqq39FWIO2f7QXnagiAImHKkT/ELJb3JjGBpHjr0wch5o
	 1chVj8mPSHn2+InYEbXn4s69U/eGe2x8WDaDGGQAbiXV7LUOMkgKC/xAOJeeFyRLyYVFu
	 bNr7iRkUpQjPOhCJUcR8us/df/xFYihqp5MmZ1R4laiLRC82mcmWJoU97SHfXw06CuzmT
	 7ZFe7HFCNBiDvDh3GCyWYrNITdja4XgaBZf3AQME3MSJKP1vWeM23xxU8eLv59LrlNUrC
	 OOFHSfQBR2TG4xYHeWthQ06f2hZWoC9wx3demNiy9HGYH7/rJw9g+N0YkIAzuyf/fJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxi4ySGP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1A2606A31A;
	Sat, 24 Oct 2026 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxi4ySGP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0521F01825;
	Sat, 24 Oct 2026 02:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792810239;
	bh=hVqnuNQZecL5SQtqAHxblwfV/eGlbMOxF3qO66kX7X8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hxi4ySGP/SO0mBB4d0vD1jYEcTWGMPziAHpgfgzx6zui+DF7Rmv9b3zQVbC/ljb3R
	 G7bbB6MUAEoVDK1glRdKAdUyToXymC4/fy1qdCbX/kz8T2Nof23WYbuO2NYKEBSXeU
	 5DxPQlXTC10xNp5W4JEEzMaRr+E/fejjBEe3SVSabKlCrDYNYQKoWKKi1PvTQjjPOd
	 fwQKTSEtenEAZ+VBQEuyucpU/3vamL9HPbvGz3c2BF9rm0pVyBhmvYAbMJKwBP4kmj
	 Gs9g1EJCVP7pM7SmjbyEt5G9Pcfix/9RdsY3/In6nqVgPDnW6z5V0TTQxgAV7tz8EJ
	 PzJdXfEx062zQ==
Date: Sat, 24 Oct 2026 03:50:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 linux-iio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <20261024035032.6ad91ac9@jic23-hlaptop>
In-Reply-To: <CANpqX3Y8Cf+ogOBeL9A+qMuHRbaAQ5Bvegt7SgkWd6pay3h0Cw@mail.gmail.com>
References: <20261018143108.14750-1-abdelnasserhussein11@gmail.com>
	<20261019040919.0381d31f@jic23-hlaptop>
	<atXkD3WIgaeamrh9@ashevche-desk.local>
	<CANpqX3Y8Cf+ogOBeL9A+qMuHRbaAQ5Bvegt7SgkWd6pay3h0Cw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Oct 2026 13:20:35 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Hi Andy,
> 
> Ok, I will do it. But let me check with Jonathan first since he
> already applied the patch, just to avoid any confusion.

If moving headers around, do a fresh patch and take a look
at whether the right set of headers are there.

Jonathan

> 
> Best regards,
> Abdelnasser

