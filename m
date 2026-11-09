Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794189926;
	b=4M6gtsDfFHXN/lXBQ7npHQjiEHj+PUOfzCTYOFBaK8lGuox06FD+mS4IqOJT7EKaKjWB
	 UnZn49DGl0NHbuHdH3O2WBFlUNf3Y0mcIlm/7df+9CkgIuoV+aMg4O3rF3hJSEDDl2Bu+
	 pYNvzPxXrwx5/kE3FZoYtyFgHKSpCdVn5HOccVa6DVB3a20yKlfZ2kFQtvb1T/3Tih+jO
	 ikOnWPKRR4oekX00gSY9hfd93AinbY9ndoWzviafVvAIalMYvaW+wzggLuduOMVKi2any
	 zDWk/WjC9hz/PvQ+3gm9vq35yVcG2B4dKXiWfjP+qAh3coZA/SSzLWpUJZ5s5gRJPyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794189926;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QVukf7r+qSvPyCCZ7Q4kemGsEJniEb0Fh/dt9c4kYRc=;
	b=fHVYT7zv/awjRbcy6nv1e7IIHasRcdZdq0cEoBw98OWWaB4kdeCSl7t/Lt3srCDKYbuv
	 sHSNxnQX22oIFaWU9EKwgC3wcXyozlfHZLAYcjvRk0b11sAU/J6aIFh8aSIqlsRr7sM99
	 7hkrmsE+3jMh2pfP0uehAB8ROHYVQTdaBvn3c+tfNo4DixOQ2NO8edCSk8mlEpbXpLifc
	 v8AGCf/HaRjCsM1twla/xDLtz1m6GZC3FnpOO4gX5i7I+NCqADv0KiF6GCimmNXXaz5Ju
	 9gsIkA5VVd9gto59ABW9WwX6VQ7jj9KbnR0mP/WElF3pdxHJ16lqaQyYsQEA4qMrCAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvE3WVTz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBEF606A323;
	Mon,  9 Nov 2026 02:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvE3WVTz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE4E1F0089F;
	Mon,  9 Nov 2026 02:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794189925;
	bh=QVukf7r+qSvPyCCZ7Q4kemGsEJniEb0Fh/dt9c4kYRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvE3WVTzlKhxY7BtYplP8zSimQAi8yDep8y8R0cetZ4aXbuOKHTyAwGPnhOlaV/o8
	 fH5WYeZjRIDpk/Nj0LKzJGz6+AtYhWbT7QQQAGKLRMZOuwlPUPM2NNvYF3k3gbu/jX
	 OMz397VBS/HtafPENpv2Tnbwxcc6J4dIXduh4aEmf6bqpOqosIN42XnzKU9x+qtv/J
	 oHBL0iR8eNOSLSbtcPLlJdJkrrt0wjaxokQAZkeO7OOwPceuTNo+OUYzHCCwDRJN1m
	 gMHz/4ec77vBpwGZQ7jBb0aGq9OFwCRsyA7DwGnraUc7od6YSTDojFH2FprDPult7T
	 DjhTbp9hl50kA==
Date: Mon, 9 Nov 2026 02:05:22 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Daniel Balint <dbalint@google.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>,
	Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 0/3] Introduce cros_ec power monitoring
Message-ID: <avEqYjEp6ohwfmO2@google.com>
References: <20261106193129.43493-1-dbalint@google.com>
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
In-Reply-To: <20261106193129.43493-1-dbalint@google.com>

On Fri, Nov 06, 2026 at 07:31:14PM +0000, Daniel Balint wrote:
> This series adds the ChromeOS EC On-Device Power Monitoring 
> (cros_ec_pwrmon) driver to read onboard power-monitoring ADCs,
> such as PAC194x, wired through the embedded controller (EC).
> 
> Several ChromeOS platforms are equipped with onboard ADCs that are
> connected to the EC via I2C bus. The driver interfaces with the EC
> via the existing EC_CMD_PWRMON host command API (and EC_MKBP_EVENT_PWRMON
> events) to manage ADC accumulation and expose accumulated per-rail energy
> through an IIO sysfs attribute.
> 
> The driver is only loaded when the underlying hardware feature is present.
> The series also fixes alignment padding in EC_CMD_PWRMON definitions.
> 
> Daniel Balint (3):
>   platform/chrome: cros_ec: fix alignment of ec_params_pwrmon
>   iio: adc: add cros_ec_pwrmon driver
>   mfd: cros_ec: load cros_ec_pwrmon on supported ECs
>
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/3] platform/chrome: cros_ec: fix alignment of ec_params_pwrmon
      commit: 346739bcdf6577fb5f10845ce339e34e855aae78

Thanks!
