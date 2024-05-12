Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BBF9F7;
	Sun, 12 May 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515894; cv=none; b=B+4FJpdGAMRzghVRYtHdSwTn5rNj9LQdyOt6qBBwcyrDovNMr/L8vuQUj/H+4uSGALrRf0aqMBTCL73HDsWL59sZWPpBr6FOVYuEA5VvcJGk9JAwEAcvOoWZAMWGPL17G+PjIpBmm+lrQtH/cvLisFjwSqpXdQRc0kYOA7Q7EZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515894; c=relaxed/simple;
	bh=u0MxQHi2aW59U0yVeUT6H8+tdanS6j5VOG+chvjIJ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ATOBO7XHHm5w5cRpA3DTXTIo1gflZifQvjdoRcORv2hoOd+Y43u09pzS22ALlPr/SD1VLCSBKGpSn6kihj/4G8A9MBr7fNXnC3fqO3lhTSZaNO2Nkl7NRfKMm7K+mrDComVzqa5pKPHoHuXwOfI2W+kW0qK7vCFcJXwNUA9W/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYNC7Fq/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYNC7Fq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E96C116B1;
	Sun, 12 May 2024 12:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715515893;
	bh=u0MxQHi2aW59U0yVeUT6H8+tdanS6j5VOG+chvjIJ8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aYNC7Fq/rFRw6svjUNCmJIcWBvymenu01cpCMGq1PEIr2HzjRM7+VicVQMVib/ATn
	 OwWGuaOpekSJUro9dInH9XkL3niCBVYU584YoMkQYOxCpIUM7BU+kebbVfmXgUGb6e
	 YviRRSP/AwqzzQ5RcX3c7LZFfm1lmG6YJDKANnC8qQGdYCxlFM5gyFMhqNDLx4vrYq
	 /owWq8/JpCH+eK232a8oa8wzVkqqbHPSndgTqqO5yGC5PQZFmfWTbNnsjaJpASMBpV
	 YDPWJ8yCPBglBnmpbXxmf6fXulagZk8rs9bzssXT7tAlGh6GCBzWwyU6xdhKcSOptQ
	 cmPpQL2RLm4eg==
Date: Sun, 12 May 2024 13:11:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/9] iio: pressure: bmp280: Make error checks
 consistent
Message-ID: <20240512131120.28d0cc7a@jic23-huawei>
In-Reply-To: <20240508165207.145554-4-vassilisamir@gmail.com>
References: <20240508165207.145554-1-vassilisamir@gmail.com>
	<20240508165207.145554-4-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 May 2024 18:52:01 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The form 'if (ret)' is used in this driver in order to check
> for returned error values. There are also some places that
> 'if (ret < 0)' is used but for no specific reason. Change
> them to 'if (ret)' to make the driver more consistent.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Applied.

Thanks,
