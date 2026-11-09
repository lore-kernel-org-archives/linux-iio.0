Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794188550;
	b=y9GevLwJqdwuuI5NEasdpYz3GC+IAC2d1CyeWIopyco/4dmWaIXHw3Xmis4DGdTWW/DY
	 Om2oQ5fwZtEay42cnhvjbOPvUvOpBLXdZKxKCd4zIV5Cb5lDFXKgwZtJKsXWMtKLVxbQi
	 CDv7kgWTQt9oj1t3fyYmfHY7/AUwHBtGWqqffSsGwM7aF/b0XVXLYvtEjxea5G28XwAEi
	 YiUEnZscTNejFohPou5/sLmZGyBpMnea+aYXAUK3vxio8dDuaxsPbkVpP8rSw023cRs1t
	 sMRokjPKK+h2UJNBqTWOjK2tulN1YihZlamJzi81GMpIaKoGy8bIutW1SU1cJUnoyRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794188550;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5MDqAcZY9aksFeH5q+wRTzlQ8j65v5wPJh73bJ/o470=;
	b=GKYVepYUMaE+2GAhO7h3xI0XQHwWlcDSlXHfUnxo8vQsGCbc5AljcqoLhqw0cB47pfa0
	 gLrgDwmFhrBwLlcmIB8jfU7FO0V+eF5MsIxLOkWh6elI39JtjqDnGNQ94SXVw86SsQtOb
	 95AFcsLWS9CfX8xhc5652RV97K20UZ8HmDTkruR/s+bvh09Sqb3QlMcB4Y/Iipa81uKJY
	 f+HjYOJmvWDM3b0Qp0SzmXUwnJnRXDsx5Elu6UWxqZOKb4WgOrNAxb44GZ0ZosD2hTgtW
	 1omnwV3T6StafZaZCg9OA36x5UHyGEdrnkB+WW9QkuCVpT79tPVUvbuFqknfY+2y/QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mc0eoXnW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D0E606A31C;
	Mon,  9 Nov 2026 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mc0eoXnW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2201F0089F;
	Mon,  9 Nov 2026 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794188549;
	bh=5MDqAcZY9aksFeH5q+wRTzlQ8j65v5wPJh73bJ/o470=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mc0eoXnWhQ2Iv5xiM4kAz7BaBUY6zJUaUwv7V6CCp9CuPKdKRk+tYGvFd6I1py/Rc
	 JPrpWcjHltb78ijqJdY74zQWP1NrGwaWwOGLJBq4oJ9z5Qu+gD6e0dXWtnOto/YFuC
	 Q5utkMe6QiY9KQUgHm/wIcFMpwEAbnHapuKD1myJNtyI8q5+M+Vr260dLClG6vS1b4
	 wmQeGsihzWl6MCdRaKmWuOAnK+gU7joCSIFr9s61EA61+NO6YOpg5fvlBK+kY2TBMa
	 JjwWiJxilnHrjHyJBqwosNWH1r7w/m6Dcg9Uw77xd5CP7bdr34c9Wr/h1TS+rM+cHd
	 59MrC7443LXww==
Date: Mon, 9 Nov 2026 01:42:25 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Satyam Gupta <sgsatyam@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Use platform sensor_num to unregister
 FIFO callback
Message-ID: <avElARDvNGQWodN8@google.com>
References: <au1FF5K9EALuqnNR@google.com>
 <20261106071904.142937-1-sgsatyam@google.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106071904.142937-1-sgsatyam@google.com>

On Fri, Nov 06, 2026 at 07:19:04AM +0000, Satyam Gupta wrote:
> cros_ec_sensors_core_register() registers the FIFO callback for the
> sensor number found in the platform data. The matching cleanup action,
> cros_ec_sensors_core_clean(), reads the number back from
> st->param.info.sensor_num instead.
> 
> st->param is the EC host command buffer. Drivers fill it in under
> cmd_lock before each command, while the cleanup action reads it without
> that lock. It is also set only for physical sensors. If the field holds
> another value when the device is unbound, the cleanup clears the wrong
> slot and leaves the callback in place, still pointing to the iio_dev
> that is about to be freed.
> 
> Use the platform data in the cleanup action too, and pass the struct
> device pointer directly to devm_add_action_or_reset(), so it always
> unregisters the slot that cros_ec_sensors_core_register() registered.
> 
> Fixes: aa984f1ba4a4 ("iio: cros_ec: Register to cros_ec_sensorhub when EC supports FIFO")
> Signed-off-by: Satyam Gupta <sgsatyam@google.com>

Other than the fact that it wasn't sent independently, the patch itself
looks good to me.

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
