Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521D333F8B8;
	Fri, 23 Jan 2026 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769156823; cv=none; b=H28QN/lSCd9+Ik+y4GU0RZ62qPLachxMDfeB4+hl+Eck1A77+TkEE5FXey71AjoU8krIACJhBuv6dCvSbnEJyJC4M3bw/tyL0Zb0dBqrnDxR29QOmiJXRPqCqGB+iVfPKEMx7BrKL199B5qLEgO5CKPkvycRubNiFIsO9wfYBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769156823; c=relaxed/simple;
	bh=QUBr/z+xN18tE0X/4sZZSzNIfqbrmoQ/tEURN3gOtI0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N92zS5aMb73n3p3reD1s2X/S9WqhW4v4EIV6e7/WQZoRik4mE5aam8zhqqIciqLP+cMPKFRFjhvppJGkBqWUSftYRWoU7CZfEoGy7+RNusBfcElK8gmkZGkmbJR6GJZtf1CXUME6uWAx+qhbmiqEzZRqqR0+MoYvKg53Ndc3e+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9VDw7lF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9VDw7lF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D19BC4CEF1;
	Fri, 23 Jan 2026 08:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769156822;
	bh=QUBr/z+xN18tE0X/4sZZSzNIfqbrmoQ/tEURN3gOtI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r9VDw7lF7bizEfQl0yZ1XjNZXOJ2cH1OsamvYTM8svbyLUXycGQZOEznhpiTkfFWt
	 wM7oSnUestf+rc4dpAlHWE8ZhMVxr+2juBK5QfRlD94pph7Jz/HezpFw2z4Zjt0THh
	 IAzgo9mwlJN2r8kB3IB8ftXM2e5DfFzHmpIZa7NdOZvVOvEdAm3jCTxTo6HSOIQqah
	 kVc2dndc25SitiRRixprrDBn5RVGQufqviNqqJf6uu/GghSua2vhD6iD6cxjxAHRBI
	 GZ2SnEJnZTZM9SWw3fqFcvkQkpt6S19atP9azivJzUypgiujGodofSmT3ladJmsfqh
	 vjdaDhFGPafOw==
Date: Fri, 23 Jan 2026 08:26:53 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 3/7] iio: amplifiers: ad8366: consume enable gpio for
 applicable parts
Message-ID: <20260123082653.164ac1e5@jic23-huawei>
In-Reply-To: <20260119-iio-ad8366-update-v1-3-8044e23e964a@analog.com>
References: <20260119-iio-ad8366-update-v1-0-8044e23e964a@analog.com>
	<20260119-iio-ad8366-update-v1-3-8044e23e964a@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Jan 2026 14:36:57 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Some parts may consume enable GPIO to set serial mode (PS pin) or
> powerup the device (e.g. ADA4961's PWUP pin).
> 
> Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

The patch series is in a less than ideal order.
Can you pull the cleanup in patches 5 and 6 ahead of this new stuff.

That will reduce churn (and stop me writing a reply on why there is
an error path before I check the rest of your thread - which I just
did!)

Jonathan
