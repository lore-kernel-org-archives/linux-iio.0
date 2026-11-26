Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659361;
	b=xsmsYCmsG9cMWrkI3t3XsoNnLu+BWUw9tmLJEn9yQ1GG5MEsGsB2FnUk7uD/ih8hEveK
	 scT94tLLx2W2XbT9QRblprmmtmcGK+NB/xe95aeY6CzVXPRk6/NxKSU7G4fQHHwPcwVnM
	 PhCj5DRJc0QvGBSiFKHS+a6Pzxhra8vdVrsyicVtrIlYNFC3B71JMiLL+ju2hP5AkzSbE
	 b3gwTwg/C5qM7bA1aeNCBxuXTs8+mW6mMJy93W1tFB2IMTmQjxrtlKJ7AEOtPt3sQ/Qfc
	 DZi2HLkonEFZXCcyxIvU+tNONcBY/km/JuUmQYhZ5DHcDDvlNklAryrry0sjEULBCpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659361;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uXljqLOV8atwMe66h5CYd6U8JQxJsBjKYHxdSUZJCzc=;
	b=Zv4M0LCHGkhQUVmjDffwjMm3MqJao9HirICyWRwjMQRfH5s/vDnpQ29ZiXmGyUh+8bYo
	 kwFBXxXBYx+cv62Sf7aHo+jwfSo9TKD0d3jJ3qI94MCihKJa3QQ38qhvQ/E1fUPvu5Gyv
	 ZP/pjvFP9vd2XZ/lUJpO0Z0y3dn4gj7+gJEV6lohTlO7qrqwnR1ScyJALt580nZxWpGHT
	 oFLmC+zteLqooUX0PfopiuCpk7M2Cq/HSxg3JPdJE3zjyTWP7My/E3583U3EomgP01HYw
	 YvZAIenvu2hm4GcrMsi1rtJ5f0H7jCw0WWGmb2wfm5+52S8KZJ2nwHq6OY2RWGZvWXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxSUjLuy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A010606A31E;
	Thu, 26 Nov 2026 02:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxSUjLuy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6571F000C6;
	Thu, 26 Nov 2026 02:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659360;
	bh=uXljqLOV8atwMe66h5CYd6U8JQxJsBjKYHxdSUZJCzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WxSUjLuyPTLWYzWPEcrW35/WUBlKF1is/wlBA+GYIirQ3HKW+kpMKiFY6nT14xgb+
	 k5WnTEK08111uaNt1Ajh9HwyzW1wlEZI6Ew+PPR8z1W/32m3vL0hH8775crFrg6U0O
	 72lMFoufauvZ8/21XMTSXmvqyVknmZbtXkBYWnkMl9zLTGzoMERWk4Neq5G+ZgLgd+
	 kVkOxdkfr3Q1CCSdtUPu9lgP/7fkA8YlA9C75L3n5fv4NIbOcuDlik+90lU9VhkZAD
	 +QwT3xqnqfIJPci7fWhKjRuSHpBu2LoZirhU/Oqzpva9KHzfMS+6UfkVRUAp3xUZN/
	 X4RD+3oDSUI+A==
Date: Thu, 26 Nov 2026 02:15:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: Antoniu.Miclaus@analog.com, Dragos.Bogdan@analog.com,
 Michael.Hennerich@analog.com, Nuno.Sa@analog.com, Robert.Budai@analog.com,
 andy@kernel.org, dlechner@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@analog.com, radu.sabau@analog.com
Subject: Re: [PATCH] iio: imu: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Message-ID: <20261126021552.2f0bc71e@jic23-hlaptop>
In-Reply-To: <543edf51-d9d0-4f18-a977-e557309914f5@gmail.com>
References: <20261124213118.63979-1-shehryar.amd@gmail.com>
	<543edf51-d9d0-4f18-a977-e557309914f5@gmail.com>
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

On Wed, 25 Nov 2026 05:08:33 +0500
Shehryar Ahmad <shehryar.amd@gmail.com> wrote:

> sorry, this missed adding export symbol for find_channel_from_si()
> and fixes tag, will send in v2 shortly :)
> 
You can add markings to say that your series is on top of a particular
patch on this list.  That function is already exported on my tree
but I'm guessing sashiko tripped up because I haven't pushed that out
so that next picks it up yet.  Hence provide the message ID so
sashiko knows what to look for.  The b4 tool has settings to do this
automatically for you.

Thanks

Jonathan



