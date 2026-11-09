Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225679;
	b=xE6gq9PnOa492NiawS4q0tUghzr9OuTSmHVIPWF1WTedgHHzyXDVKk0qsubJQeCHr+dL
	 412AS1ANy/XzsGqui3T8Cm5HI4k6ZeB5Kkc9dv1/KyBmcI/ZTj0yYoegacj9B2MclX+CX
	 4JF3WM68X6ZmxKfJtrJPPcdrfhHyset0gJ0TRa+bIVOSWXCI7tXkFkskeYShammFVOgVl
	 ErYho86yofloyktmM3pimNYnCUGUbevk+oWAzgO3baEXU/TyEP8r/ebLHtdcZRiymypuf
	 qXYHOaPXgMFchp1PJ5eYo7Yz5ZJh6XzKds3Tb9bG+v5Uw6z7gJKLoK4SrieO+QCV86A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225679;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pxzG4Z9tUr84C+n4G473WYz9seP+45U8TnoBcPvES30=;
	b=4pVfMdZHrY7Z84DMgoTrjBtzVXvegjoydJllnh3N4n+zJPvvMe+R+yTZdH3+7CpP7qe5
	 H5nIwtnrwm0snTNQzH+nhX0iUJgNW9idsUTJc4CjRoM+GZSbmRNK+Ed0m3RX/wtplAVog
	 oKLsD8jp6XlzhboITpzpe6qQfQXKOzAvbiRILM257tCWYJdXKy92c1T/7jx7FfwWqxUjO
	 6IHz0PWz/+pGSTHfHHQJrYbqIHPrHTP0wAx3z8qEIbqnj7zWUCjz0ZBO4AWda08OhtPmh
	 jOkTeezslPe4gyBMetJkKwpoqeRqT0lPnwgf4BfZq4hQOr0F81nzAwhVfFlGcizgk/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Srlba1QQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B671A606A31C;
	Mon,  9 Nov 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Srlba1QQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794225678;
	b=H6pnApyDwvQKJiIZCb3HhNC9v2+J3C5JqiPDz+Manf3ufmUimH6KWLzXq0mmZXGAic6p
	 C2ueCr8fnU6wrtUBDQOKE6sDqwp8P3VgNngd9vdpB9D8bZ+Ns2BQC5I7OoFtl+BQ3wsWI
	 6q0V0fzG4g79oP3OTzli2vuTVskgMjYan+ze8xy+tefDQjAssaQ1hd88EhwaYNs0sxoH/
	 6PK/x1IyuJST370tcCktv/32RVdsmb8K7z51B1QdZ/TMwUlbsxxbywhzOgIpCpvL5CNYX
	 FS0cAbgzu5oLRp8QD/bdT7y/Gp3dBuAINoQVd1SslNJEEt83RCsznZB2WqCkygTQkuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794225678;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pxzG4Z9tUr84C+n4G473WYz9seP+45U8TnoBcPvES30=;
	b=oa3tCVDihpcrW0ftMjvjWyIpztvziRl5Vjq4grR+K+5MaSqldOypR+AtuadAmhHunSvi
	 a4vujr2Njk3Si9QaidHaRj/ZXp/R4g4268sozU3rrPVqwsK0flaTAfW9twniF+jdnVJSg
	 q9QxGVeUlto8owAVazlgy+QuJX7Ak6wSFeGLxBhSUSUgtd1Bb5vB5CqZE2cRkqWwrFvVA
	 jqv/pusnVJFzxy8Igd79YgEbUtkh4DcVBvCEtpLvurwvrGtddV0ze+SqgmsmzYdf6Wk3N
	 Cc1USby9/KcpjbQEryO6D4q5tuDU85FS/FdPvqjbok7OXxVmXjse5phnnfJDnMs2+Kg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 8A9AE1F008A1;
	Mon,  9 Nov 2026 12:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794225678;
	bh=pxzG4Z9tUr84C+n4G473WYz9seP+45U8TnoBcPvES30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Srlba1QQ6QNms9fdYyWQZmx/GjFcwwjH25qwjZj8EmvqEmODeEeiehT9y1c+OVoyH
	 DmJeqxoVEIMrghgFYGxQac3PnwmT0fkcLVmqo1vPnfje0RmjLR1wBOjPr2x0p8AKcv
	 X8uGGisEeu+m3AU2+uhij2JkIw8IcEhLftK4ES2r3ebS94RKsS/21Cl2PFNd6dGvsy
	 EX7jkgOfi8islkmPcGRcg3cwl86pEP1JD9liS7x+314M9t6FMedGaSBM1ndaMj/Bwe
	 UdlmkP+a9kl1XyApqYfvqf+Yr/B+VL9M9/p4Au+8Esf+nOLkHIC/iaAECpo5yPeyPQ
	 +hLXkrhA8EadQ==
Date: Mon, 9 Nov 2026 13:01:07 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Akhilesh Patil <akhilesh.patil@linux.dev>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org, akhileshpatilvnit@gmail.com,
 akhilesh@ee.iitb.ac.in
Subject: Re: [PATCH v2] MAINTAINERS: Update Akhilesh Patil Email address
Message-ID: <20261109130107.000056f8@kernel.org>
In-Reply-To: <20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
References: <20261109063924.GA118887@u5ce4748bae3b54.ant.amazon.com>
	<20261109104443.GA531570@u5ce4748bae3b54.ant.amazon.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
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

On Mon, 9 Nov 2026 10:44:43 +0000
Akhilesh Patil <akhilesh.patil@linux.dev> wrote:

> Move to my new linux.dev email address akhilesh.patil@linux.dev
> I plan to use this email for kernel development going forward.
> Also update email address in few yaml and driver source files.
> 
> Signed-off-by: Akhilesh Patil <akhilesh.patil@linux.dev>
> ---

Next time please don't send a v2 as a reply to v1, it can break
tooling like b4.

-- 
Kind regards,
Joshua Crofts
