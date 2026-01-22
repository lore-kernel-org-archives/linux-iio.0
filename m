Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3C5225A35
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769114245; cv=none; b=IH9FmolH6xgPYAoz5a/fMKCjCb+t0M4Dn1OKJpqj8yWqg6gmMIDZZijQWeC7IwnjCO2vqvJ4JoYk15fxMU77L0sI4Mph44OtO/NOMyf/zDt3dZI5zo1oQSnRd6fOPmghNzQm4kbczqbMp+5H2zUr5Lk9/J4Duv0VnbzftLBD2jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769114245; c=relaxed/simple;
	bh=t0dUDxojzklGc7/4nqNpdXYAFiIQqZ18B+Z+LO6VqYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEq++umbqq0vn5vvQ/Ro2Eb8HBwc3oGVm8ZJol47J+K2e/spkxYtmKXu+SvrEMnlg31zNpxplfzP/LFrZJO1E4BluFZ2XP/PFnnzOmT+n/PGWBcZb838xYnaDO38PbWp6rH4vmUEAoer63o7jDH+4VjVc6XX1QeOyIKFHIlNXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeFr+VSJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeFr+VSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DADC116C6;
	Thu, 22 Jan 2026 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769114241;
	bh=t0dUDxojzklGc7/4nqNpdXYAFiIQqZ18B+Z+LO6VqYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CeFr+VSJmskK3HJcG19b/ouL0CljHxesphBdH7OjJOizOPfehxT33tjFx4aFx/Ro+
	 PfVgO00zydWmvvakYSV7ZDZ7ZrYOwFJNgPoNpZoKJvS9OrJ6Z2AJ9/IEwkRiDv4t55
	 rIsIiyZVDDQWx0eok2o2uVmkoj+e0AB+TdCJgBnVn/rpyRK6hbCWhjyPDQE5Nx/8DL
	 YjuzHihmlMKgvAH+tL9qCZ6w+vwQo8X5Sj+GDr8E7WtzNs8UFQq1VzpFYalN/PzaOw
	 dMfA3TZwqdkhmj5xuhu770JY/EQs5bxDbLjg+Ah6TSZiW/01YUfOtgvnj0BlLa6kM2
	 PT7A4tALoIs8Q==
Date: Thu, 22 Jan 2026 20:37:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: nvaccaro@google.com, tzungbi@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: cros_ec: Allow enabling/disabling calibration
 mode
Message-ID: <20260122203715.3b44c883@jic23-huawei>
In-Reply-To: <20260121164657.1433637-1-gwendal@chromium.org>
References: <20260121164657.1433637-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 08:46:57 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> 'calibrate' was a one-shot event sent to the sensor to calibrate itself.
> It is used on Bosch sensors (BMI160, BMA254).
> Light sensors work differently: They are first put in calibration mode,
> tests are run to collect information and calculate the calibration
> values to apply. Once done, the sensors are put back in normal mode.
> 
> Accept boolean true and false (not just true) to enter/exit calibration
> state.
> 
> Check "echo 0 > calibrate" is supported.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Reviewed-by: Nick Vaccaro <nvaccaro@google.com>

Ah. I replied to v1 without checking for a v2.

Short version is; Needs ABI docs update.
