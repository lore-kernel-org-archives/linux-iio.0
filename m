Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9DE346AF9
	for <linux-iio@vger.kernel.org>; Thu, 29 Jan 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769708178; cv=none; b=H2qTevbKfFtcrZ+bQcQRyhcj7o8B5zbFgDrp6Q+oH5paw2TdkRMucdow6FJ8ZZ7QsqlX8tcbqs9a6XVw+Pb65C5JAt7aD1if812W/u42vMN88luCTCm9IEY/HvpLVxk3/7A4R5Bp7efvo1j85KN0KmVyeVl66nWyp2Vh9lrNYMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769708178; c=relaxed/simple;
	bh=xESkBRk0d6kJ1wyxZPC9ygUfXhhyUCn3hSnvDpUW6+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Au2eRWZDPhC1jUIQVR+4IGDtbbCrkGu3f4e8GDAWSe4vcFDvXz9w0CRsfG0LK/F148kK2eBqCUACE/ZgiLp1UfuS5NqHhfvZnSNWfpYAEbR8KkemOvG33Qq+/6RNJa/uGeK8CmDKBPyqiHs6R6qv2b23T2n6prk9yP3sOk+mqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcOyLfzN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcOyLfzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694A7C4CEF7;
	Thu, 29 Jan 2026 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769708178;
	bh=xESkBRk0d6kJ1wyxZPC9ygUfXhhyUCn3hSnvDpUW6+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GcOyLfzNuCxEsngjoY5NLFKzN+rK/ciupmjZrRmqmUWoeDCPGVbjB2QYUT9Ftlbd9
	 FmIAmX3KU23L653fWMVhbOXtrJakmBTLTsC0MXDeYcf1EPpEk7bD+UcMWc06iTNNfQ
	 glQtYaPUb11VjlfcXC/jO9CqRdhrRJiR/0dC0Eh/jA+vQcJ0/jTb5a20mSAhkK1YOe
	 JbsMJqpxcO+8rUwLriS416dtsWIoSUcEQko1d+crAhTQOPl/xIIYOrqhEIv1npNKv7
	 zcShV+Lbb9FZX/2csBrlpsU2WXaiDu1z5gSj1Q5XMOuTDcg3ayRBpwW4rFwUMOQjJY
	 1LPlEAq28tcAA==
Date: Thu, 29 Jan 2026 17:36:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, nvaccaro@google.com,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Allow enabling/disabling calibration
 mode
Message-ID: <20260129173611.77c520bf@jic23-huawei>
In-Reply-To: <aXq57lVUZmZ91nWZ@google.com>
References: <20260128032702.1714041-1-gwendal@chromium.org>
	<aXq57lVUZmZ91nWZ@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 01:37:50 +0000
Tzung-Bi Shih <tzungbi@kernel.org> wrote:

> On Tue, Jan 27, 2026 at 07:27:02PM -0800, Gwendal Grignou wrote:
> > 'calibrate' was a one-shot event sent to the sensor to calibrate itself.
> > It is used on Bosch sensors (BMI160, BMA254).
> > Light sensors work differently: They are first put in calibration mode,
> > tests are run to collect information and calculate the calibration
> > values to apply. Once done, the sensors are put back in normal mode.
> > 
> > Accept boolean true and false (not just true) to enter/exit calibration
> > state.
> > 
> > Check "echo 0 > calibrate" is supported.
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > Reviewed-by: Nick Vaccaro <nvaccaro@google.com>  
> 
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>


Applied to the togreg branch of iio.git.

We are very near the cut off, but hopefully linux-next is happy with what
I have in my tree when it hits it tomorrow and this will make it.

Thanks,

Jonathan
