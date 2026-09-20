Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB8E33B6D9;
	Sun, 20 Sep 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789926791; cv=none; b=eM0o4unZsDjO0a8Y54H84jyq7+KbD1JIKh/oB8Rr74jZnhZqiM2GfJKHXfZyEbT9QUeHqJzmWE4L2wfrNwf4Ic5YNWhhpHTOE1Ex6g5ODgaLUrT/tU+JbHICOSSX6r9/22rwFxezFlLNCwwyqa2gz089sW4lH3vIw6g53o7Owj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789926791; c=relaxed/simple;
	bh=ukN7nS1+qUwqU50dn/BWC4o8e+Uwn5xh50wIIbOLZpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ezl0JRO+jrld0oeSw7MyTu/yd8VzbXsbMLb0WOmXOZ5JOqUGymydd0VmKd/RU6Q5sCwTiSOcfbljmP6LTa1F2u0sCFkdz18PUoSlvK1PLepGHA2tt9eEkko4IBn7+aapK2yFmP4rqOIFNwvRfJN4sflbFfHpaLwku4ApeMYtfbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SX3LRSmV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SX3LRSmV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027F81F000FF;
	Sun, 20 Sep 2026 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789926790;
	bh=ctlsaeNtXTOZUyuOu07NnlzVe5hufdMrt/i7PznBcNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SX3LRSmV6ZuhJzHNx5DFSuJY/QhhZ6SebgeECUpnWoXngURjVitl01AUJKKdq5pf5
	 oL7j4kXUEARqAMDZOUUR2omRzclp2dDQXIwA07Fk7QjwruOZqGIrpJBLpfuFI1Dpah
	 R6FhDjxbSDK/kcy7JOaG907n2U/Ggj3sbUGr4P6HsupnQm8CYNA58kN35i2BFUa5XQ
	 t0JU+W2LEuUuvsy73CdHX2bVep7Zyu+qdEHtDi1T26brHtZSBpuCTGPbOlzYGnOy09
	 7x0NSWMQYRDxzDIUVxmzIGVHpUs7bpqFLjgS3T/kE3FdjE5/JLuXZCFZxd7H1wN5tq
	 VArQASUYkPUmg==
Date: Sun, 20 Sep 2026 18:53:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: chemical: sgp40: Add secondary chip
 functionality
Message-ID: <20260920185303.67b8e10c@jic23-hlaptop>
In-Reply-To: <20260918134019.1101308-1-jmatko@utu.fi>
References: <20260918134019.1101308-1-jmatko@utu.fi>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 16:40:16 +0300
Jaakko Koivisto <jmatko@utu.fi> wrote:
I'm not sure what 'secondary' means in the title. I'd just say
what you are adding
Add serial number readback, self-test and heater control

Slightly long line but more useful than a vague title.


> Add functions for getting Sensirion SGP40 VOC sensor serial number,
> running self-test, and turning the heating element off.
> 
> Tested with adafruit SGP40 and waveshare SGP40 breakout boards using
> Raspberry Pi 3 and Raspberry Pi 1.
> 
> Jaakko Koivisto (3):
>   iio: chemical: sgp40: Implement get_serial_number-command
>   iio: chemical: sgp40: Implement execute_self_test-command
>   iio: chemical: sgp40: Implement turn_heater_off-command
> 
>  drivers/iio/chemical/sgp40.c | 159 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 157 insertions(+), 2 deletions(-)
> 

