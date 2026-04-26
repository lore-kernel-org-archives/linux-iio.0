Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7DF146A66;
	Sun, 26 Apr 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777211318; cv=none; b=cjPuj63DapxIRt3+JOMHyr4o4ykNuMPPhAhKnrn0tpMJfKk5GmHdE3yz8JW7lty1A7u/sMxxMQSDZeY1pYNkJOG1YLYqAZKt7s2tjV6Sp087myVZYqJAhFL+JYQbbEf20zrT974JoNOHwzXE0Hrm2OHNLDTWlbzXyl8BJJdDnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777211318; c=relaxed/simple;
	bh=0sDtvMCAEMiY9w2wAKpe+fZa9eQsBUv+GF6Z7tLO2P0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJ7lwCbdzSBDdKH+hbS13obaO3yv9xMlG41rFqy5jFi9Gcs9+KQtkbuFWila4hQbr5Bm1stL9CHDL+nDhuriV3GaUv0vWxph2MiTbGgrNyXl/Ptp+jdU1nUWAj5EYYNYLBMu3sfRIKf+wZ1ENwf9/4tSsKFWlGUuo7vYBoVxq4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlpBPARM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlpBPARM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F086FC2BCB3;
	Sun, 26 Apr 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777211317;
	bh=0sDtvMCAEMiY9w2wAKpe+fZa9eQsBUv+GF6Z7tLO2P0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlpBPARMMJq82+kcwPRBfb7WQEE4Kl8wIuQNYotYObrkpmBSJKwbim0VG9faUKpFP
	 BmaR87RVrHQnS6KcQ6DfIfr+mkfl6tBEeyXr2gpRhlztO1XaBzQwIRB1V+la6pol4w
	 UZkg6hsBZx/lCQ9bYK8cssNFxLMoWWkUF9HfQGRGcPPfp9y+E+W7dQIOiAyK4L9sXL
	 /b0e3Gj8PTj68FDFwdd30oNHEqzJiBWl6F2SZrSwSaZgQbSz66OZQbWRJvOgCJSvAO
	 PwGidkTqKPl0ht4PxWGQWQntAY88R4ozsUyUatxZE0dTuD+zsP2Yb7ReExksM/cQgJ
	 WvZ0Nlq5Cp7WQ==
Date: Sun, 26 Apr 2026 14:48:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
 Jonathan Cameron <jic23@cam.ac.uk>, Greg Kroah-Hartman <gregkh@suse.de>,
 Michael Auchter <michael.auchter@ni.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 07/10] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Message-ID: <20260426144826.28df820a@jic23-huawei>
In-Reply-To: <20260426-ad5686-fixes-v1-7-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
	<20260426-ad5686-fixes-v1-7-7c946a77794e@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 09:38:08 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Fix powerdown control by using a proper bit shift for the powerdown mask
> values. During initialization, powerdown bits are initialized so that
> unused bits are set to 1 and the correct bit shift is used. Dual-channel
> devices use one-hot encoding in the address and that reflects on the
> position of the powerdown bits, which are not channel-index based
> for that case. Quad-channel devices also use one-hot encoding for the
> channel address but the result of log2(address) coincides with the channel
> index value. The issue was introduced when first adding support for
> dual-channel devices, which overlooked powerdown control differences.
> 
> Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")

Move to start of set.

> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>


