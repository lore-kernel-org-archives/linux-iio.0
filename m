Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EB4280CD2;
	Wed, 20 May 2026 19:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303683; cv=none; b=IewLqf1Hfy/vFq2KTX0JMK4gxMg3suQzROATPNCVN6EJzuDnigtQCtLIfmqq98Vx+FXPfOtpCH4SsoioGnARn6S5Yw6lepBnf+YiJXs4lDfDWWliLihn/skwa8aLV+Jb9Onva3+QZmGcIMVorbJSimH8JtMbqlzTn4a+61kmOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303683; c=relaxed/simple;
	bh=iVSE/v84dWE6rQX0OGt7JnvQ7VkXybimImYUGCqQ9dM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jeETTrhI49uNvKKXZJ+fDl3DE7IhiPGpPiiEAoHg3BvR2CxKvCwRjNbJr2vxYI3acJLeveYAKDGvBcnYsFOelLDLSIPVMbIQ9KrcEdyG8UNp8n17Fe9+rgnYG2XX7fwBA9jZne7a9GSExGWe3g3XnjSZ5ZUSFeQy68hvNO1Btgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTENej5s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTENej5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 921601F000E9;
	Wed, 20 May 2026 19:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303682;
	bh=0ZvBdw8BvU6WsVszBrpycqZqyi2tzAKxOzXVlBSmv5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=bTENej5sbRKUe3CwlgmFnKM5E8B5a5Zld4+csIl0f5JJ7LEk1YguOdprmbuxrPK5c
	 3ZlCLkQ6LxaECR0lYDJsFbhl6zNTgOKG0drs/TG0ao/XoGMhLPPc6sbBkH54vzCVKt
	 5TEl75i97Lonp/NTn8bWv9N3eLa+PfquC+Laun3yZQ4MHkQ604zEFVxcbbv96YmfFV
	 weGnMaarHsBxIBSeyC8kwGKx7Nth19t4oXe0uRh5sglb3aLgkMGWV27gLkRyYFH02d
	 FoZOAR/PJxebaPZjBog1NZHlsrtRYW0Q9iOna+SW4wYRjJ2FJfsWfLFG73je54ronT
	 CbK6wcmDJ52uA==
Date: Wed, 20 May 2026 20:01:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: u.kleine-koenig@baylibre.com, gregkh@linuxfoundation.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] staging: iio: Use named initializers for struct
 i2c_device_id
Message-ID: <20260520200114.68509944@jic23-huawei>
In-Reply-To: <20260520122105.15299-1-sozdayvek@gmail.com>
References: <20260519140624.1585534-2-u.kleine-koenig@baylibre.com>
	<20260520122105.15299-1-sozdayvek@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 17:21:05 +0500
Stepan Ionichev <sozdayvek@gmail.com> wrote:

> Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
> 

Applied.
