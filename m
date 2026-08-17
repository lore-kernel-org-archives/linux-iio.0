Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24E1F0E34;
	Mon, 17 Aug 2026 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786929845; cv=none; b=X15ENQUQj9RgHrI6qHyb5dp1Hy9CBKb2P+dJPu5uBT7v32S+EnVKRWUGKSZjB9/h4N+JftI3qaDIZkX2xRFrLjaWIQdEy4E2w9NNfhbRMJbpUv8GzG4B92XmfMXJLH7JkGSZ34Ez5xVE7PsqqA194ZGUzmRPZvXop8qLlBxlEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786929845; c=relaxed/simple;
	bh=QVqA95JyormiNSLPNW48umZkDi7HkwJ9H2hR60TyJYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrmlPRfSBMrowBYjvwK8sng1Qx2BSTvceSLtGi9NJ5HQn0WlFDK2ffczBMPAS4Mn0hRksxWILn4gxzZqV4e4CV81TlclnTqJWf6i8GV/E+///t2DbhGErhwKXChionKLGNdCl+ELzogMBLBwDv4PsfGHXOZNYWO4qKQ54Nr6fHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZxfWV/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZxfWV/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5809C1F000E9;
	Mon, 17 Aug 2026 01:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786929844;
	bh=PfOSsX/psyqCHkdtyvFwgnUly9dAvFm8ddCKQcQbQi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CZxfWV/dq/ZPGGq/EJaLf/ylb3jZ2hxp3PSxykLs87TxlX2bwWlksDIMVBh4KC19R
	 /il1ogH3eUW3BsHqI+G62w0ZB0YBOP+Bxjkr+rj9ua4vgKyMS5tvAK9vMNpoaDRUfU
	 0Td07uoxyY14dvuaWnzyy/woinrcTNZo8IZyHmcB9357bxqxS11BIaJlaOlKinw17I
	 x74vtC6AVKSoDrhgISeHxtv0BTVImHR3Wzh3XEnXEq4fP5zTpE8OFXD3VCeXzPhp3Z
	 73LauQp+1X6GD7+WtHc8QKBNPO5Flgt/qFzA5zwJ74KWf0PH5APAQzcF+xrZxYI/u+
	 G85d7y8LU8zEQ==
Date: Mon, 17 Aug 2026 02:23:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Javier Carrasco <javier.carrasco.cruz@gmail.com>, Mehdi
 Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>, Topi
 =?UTF-8?B?U29ua2Fqw6Rydmk=?= <sonkajarvi@hotmail.com>
Subject: Re: [PATCH 03/12] iio: adc: rohm-bd79124: Fix GPIO mask check
Message-ID: <20260817022358.16d93b81@jic23-huawei>
In-Reply-To: <02b3f620fb3aca640dd2c7f53cc5af1e52e68149.1786347811.git.mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
	<02b3f620fb3aca640dd2c7f53cc5af1e52e68149.1786347811.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 10:50:49 +0300
Matti Vaittinen <matti.vaittinen@linux.dev> wrote:

> From: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> The ROHM BD79124 has pins which can be configured as GPOs or as ADC
> inputs. The bd79124gpo_set_multiple() is intended to ensure that a pin
> which is requested to be toggled, is indeed configured as a GPO.
> 
> The check uses XOR, causing it to fail if mask is not exactly same as
> GPO configuration. Eg, if not all GPOs are asked to be toggled at once.
> 
> Fix this by checking that mask does not contain pins that are not
> configured as GPO, allowing some of the pins which are configured as
> GPO to be untouched.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Applied and marked for stable.

