Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792974475;
	b=WVa/dmKbszKApILFqnbUugB4NnpVpeV1buUSxzZf1sTdMxdGT9vLeAWydMp9dU5V3gav
	 QOrdNN3f5EeHWh/t2+PMC9xD7V/4UtbdwV5McI4o891vo56JhBN9YVu1/NYa3P/mwhsbV
	 hS9AvrFbO7Wvx18cT59tix4b/l1GHFn61RzYKyM6NsVh5XM6z06QU/Kj+4iTI/qUTySJx
	 ExD6qaHk9iNNGO+9t10ctGTcBbIk6u5T6h08XucoW6CxsRLYMtbLfZ35xYQnP6SwQht4V
	 XVVJpDSsRxsWvQR9VEmz2hYXajDhmncPu+SxMjXG0+ktCh+cjbuBZb2k5102kAgvYgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792974475;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UbSOh/IZ6Ef01MAVctP8fMGAQq8qLAkB6lnPM5iAOxk=;
	b=A7jJJkj+cp6+78AFfTBQe5D0PSxhB3YHIEyHimF7wA+rFl2tPDtiY8pKViLNCFD+75N7
	 jE3xlXOJ3z+Fht4IupQ7bK76cqL6Enpte6jQZs2M+20nDLDlRfnbcMO27YucCXqCaUHT0
	 DYRyK+0B3ByaglWLZiyU70OUGJLJ7404Q8GcxYkiWAb03ilOtunUJBgRz0Yi8CeXyJYZ8
	 trEAcBFdVrwtCsU4KB83B5iIsiAKUm7m5KTCKAA1pkBwFNQ/BpatFX2btgufB5WZ2dyHP
	 euV+dA4SClTqoYhor14V4/r/wYaZ2jbR8qp0cNuoGBsDryM+eQARRryIE2sXNVkNShg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=y3ZrJh7Q;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936FC606A31A;
	Mon, 26 Oct 2026 00:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 936FC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=y3ZrJh7Q
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jCZGK6jLfzlfvpM;
	Mon, 26 Oct 2026 00:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1792974470; x=1795566471; bh=UbSOh/IZ6Ef01MAVctP8fMGA
	Qq8qLAkB6lnPM5iAOxk=; b=y3ZrJh7Qtdi0qYIUutS41Wk5XxP99W/de4X9srBq
	wyrV3AHi67dxsrGBnKb9Y4S2CpDr27+wYAyc7b7OScoqF8P6gU0nH9BlP5A4PGQc
	/1kNkvJoVeQSRdiFn8X6l7CP5CxsgcQpJlv70kZbNE93WpM9/Xz4oj0fjJJvVd3X
	EGUC8t0LrEQNWFwwS4uoGHYN500+5qNmtVXKb4vMHRbutkr5IJgGQDLlGnO8cRV0
	r3kw3NrDFjNOYN3jFOZnHDUUjNZZ6GUxRHV9ixTZhLJufhBh8z8OgUixWVFVPmXe
	nKrgfOooFNznTZZHUJEaeFRZsVBqN9GRNyoh1+Utdh+A/w==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tGSHd7LPcoDz; Mon, 26 Oct 2026 00:27:50 +0000 (UTC)
Received: from [192.168.51.14] (c-24-6-239-25.hsd1.ca.comcast.net [24.6.239.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jCZGF2jnfzlfvpK;
	Mon, 26 Oct 2026 00:27:48 +0000 (UTC)
Message-ID: <f151a228-30f9-449a-b71e-7e2ead0ae01f@acm.org>
Date: Sun, 25 Oct 2026 17:27:47 -0700
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: qcom-spmi-adc5-gen3: fix lock annotations on
 mutex helpers
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rupesh Majhi <zoone.rupert@gmail.com>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marco Elver <elver@google.com>,
 Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
References: <20261025191510.22261-1-zoone.rupert@gmail.com>
 <76bbebb4-7337-486d-8f21-a39bcb6dca93@acm.org>
 <20261025215954.73549810@jic23-hlaptop>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261025215954.73549810@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 2:59 PM, Jonathan Cameron wrote:
> I asked that we didn't do this because intent is to follow with
> remaining fixes to be able to enable this IIO tree wide.
> I'd rather avoid the churn of piecewise makefile updates if
> we are going to be there soon.
> 
> Rupesh, if you think that is coming soon then please just make
> next version of this the first patch in that series.
> 
> If not I don't mind merging this sooner with the makefile change
> to ensure this gets used in the meantime.

As maintainer it is of course your call how to proceed.

In case anyone would be interested in working on a patch series that
annotates all IIO drivers at once, feel free to borrow annotations from
this kernel branch (entirely untested):
https://github.com/bvanassche/linux/tree/thread-safety

That branch has lock context annotations for all drivers in the entire
kernel tree. I'm sending the code from that branch upstream in small
chunks as time permits.

Thanks,

Bart.
