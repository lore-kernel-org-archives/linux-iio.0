Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFF63DFC94;
	Mon,  4 May 2026 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908235; cv=none; b=SOss827DWZcMI2fICPsF2oSjI3MRVmQBIhOYsFN37X3D1z9oYsmEKSxSTxfnfoe9w7+lzWrNJ0bA3qGw1ZYz3zkYuMlvewsDlO5wEwU8Khlsb1HI6LC//1jjKII20weVSJQqVFvl/F6rQe4yrxoVWrZ6E6jb8dLY/OaVRmeI+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908235; c=relaxed/simple;
	bh=oW9Oh0Gj3laVcHDkSxqdArWSdGM+4ghbAz65YgNZj7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGNV+6j2fSBtgQvnqKAPxDfpN4jUrf7w/qxUFIa2zmCcHmjQ5XWiB/68IZIgHuLQ+ofo+prGr9fHIzlaZ/wKracZBgPCS6B5y6pK8jlepScszRnhVN5+gwLai8mgVUEazpjVlj39jf+2bgB5lyMofzrpvdwNUDh/KNCKKI+NNgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjtLsW1B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjtLsW1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFC2C2BCB8;
	Mon,  4 May 2026 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777908235;
	bh=oW9Oh0Gj3laVcHDkSxqdArWSdGM+4ghbAz65YgNZj7Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjtLsW1Bbosq0cTKZpjzx/DUz1qBTu8dXI7/oCEEmSS+1qxH5ZoGa9fw3cbeCOEZX
	 /6ke4btWmbwV2g2IDxmlf5zejywQgKZop9DJeUcchm0Xc+IrTseMpeuhZfRXs13IRo
	 IpRY+XxJdwk77tKyBPnZKt/D13g6vAF6u+TJIvekzIM4ZKvCEjekzfW25QdKkzmGeQ
	 X8/2OItu44IZrBjXidOYtG5eykbcKLLAhtsGMRjORpuLh/r8fdLAZ1uhkqAzKfxQ8Y
	 oznVPVxvBNau0fnkO2LRU2v7qEtt3rbKRkctwveY7IBRJpXwr6qKkl5U3+Cgt0Sxj5
	 hE0oREDR4/jnA==
Date: Mon, 4 May 2026 16:23:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angus Gardner <angusg778@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 gregkh@linuxfoundation.org, lars@metafoo.de, Michael.Hennerich@analog.com
Subject: Re: [PATCH v2 0/3] staging: iio: ad9834: driver cleanup
Message-ID: <20260504162346.53668925@jic23-huawei>
In-Reply-To: <20260504092059.1536094-1-angusg778@gmail.com>
References: <20260504092059.1536094-1-angusg778@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 May 2026 19:20:56 +1000
Angus Gardner <angusg778@gmail.com> wrote:

> v2: Split into a series of three patches as suggested by reviewer feedback.
>     Also add a missing dev_err_probe() conversion for the SPI init error
>     path pointed out by Joshua.
> 
> v1: https://lore.kernel.org/linux-staging/20260502021815.3953423-1-angusg778@gmail.com/
Hi Angus

Series looks good to me (Thanks Maxwell and Joshua for reviewing!)

Applied to the testing branch of iio.git.

> 
> Angus Gardner (3):
>   staging: iio: ad9834: simplify -ENOMEM return in probe
>   staging: iio: ad9834: use dev_err_probe() in probe function
>   staging: iio: ad9834: fix chip name typo in comments
> 
>  drivers/staging/iio/frequency/ad9834.c | 24 ++++++++++--------------
>  1 file changed, 10 insertions(+), 14 deletions(-)
> 

