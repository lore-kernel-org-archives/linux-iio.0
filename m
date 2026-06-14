Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC392E2850;
	Sun, 14 Jun 2026 18:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781463479; cv=none; b=o+87vgoZCKREWdZPPGQq5BbC61CyLDjiosQRmJcNcy9up7gXcIPo6y/9z0gUzwgdWfQOzcjBUxm35Fu3a1XFzSOZyfuAuPgLxgUm7lFnbbrO6aiF95cjJFpTV2WbDy4qdWx4VPzVjW6OobPFe55rOu43nv5vkN+rT3hmbyRr72I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781463479; c=relaxed/simple;
	bh=50uMYi+olBpQ8uAhi/ge91V3PHym7V5eQkDz+8/LHV8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JKWEkTCJEzlbY3b1bXDEK9fZtWGzj2h+amZLgd+OuwcHOdY0+Wrs+dup4KmWwE3AwIuN6P6s4CJjqQaOMP5f69zkoHuRIVkxJ2XHURpXRCkZggy2wQE0W9Bw+U+tfueA4psngu/wyKr982l9EL7zNPPW5e+/WyB1qTczemE2q3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b//l+XPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b//l+XPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC9E1F000E9;
	Sun, 14 Jun 2026 18:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781463477;
	bh=wyZ0QF95IKd7SIwzFZUgaekyNSB3DUqaJFJ3HLGWG3E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b//l+XPJ8gNShSQ+ltSArVmJJXOrKKHRitIOcT/t26dGFCW0FA80TJeGVB2aP2VKV
	 6cuIIwjGQWFvcvfxhuskWgChewM9JgIix1nVKV54B9uaUeWpwAicJDOwXRyKImlhyY
	 k8ZFUGD7N0vfcNYCqK91wZ7LDIwmDs3odo6j3e5F7UIsHUTTyGmQNQMIVlvolP1F8A
	 AdQbJo4hqRnNvP5GHuTFIglcMY/Nm3HJtvIjfOXIhC2HSlTUmpmuCQXrJ79+qQo5xB
	 rGn8sewN7eGUJxJ6f3uD0p+FIzBtzUW2PaJsV+YOk4IIVNwGpNFCV1RpJfPHwks2DH
	 yoF4NYubRenrw==
Date: Sun, 14 Jun 2026 19:57:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>, Brian
 Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 0/3] iio: imu: inv_mpu6050: runtime pm fixes
Message-ID: <20260614195748.0a5eb76f@jic23-huawei>
In-Reply-To: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
References: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 12:09:37 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> This patchset fixes problem with inv_mpu6050 driver,
> when it fails after device is suspended by runtime pm during a probe.
> To simplify runtime pm handling in the driver more devm-helpers are used.
> 

Hi Andrey,

https://sashiko.dev/#/patchset/20260605090940.1103750-1-andrej.skvortzov%40gmail.com
Has some feedback. Please take a look.

You may need to do some experimentation to confirm but I believe
you can just remove the pm_runtime_get_noresume(dev) and associated
put().   Drivers automatically try to enter autosuspend due to calls in
drivers/base/dd.c when probe is complete if their reference counter is 0.

This dance is therefore not needed.  However, please confirm this for yourself.

The other bit of feedback about not powering down if devm_pm_runtime_enable(dev);
fails looks plausible but maybe I'm missing something.

Thanks,

Jonathan


> Andrey Skvortsov (3):
>   iio: imu: inv_mpu6050: fix unbalanced regulator_disable() calls, when
>     probe fails
>   iio: imu: inv_mpu6050: use devres-enabled version of
>     pm_runtime_enable()
>   iio: imu: inv_mpu6050: control vdd supply using devm-helpers
> 
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 49 +++++++---------------
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 -
>  2 files changed, 15 insertions(+), 35 deletions(-)
> 
> Changes in v4:
>  - update commit messages to address Andy's comment
>    about functions, callbacks and runtime PM names
>  - move pm_runtime_set_active just before vddio regulator is enabled
>    as it was proposed previously in v2.
> 
> Changes in v3:
>  - make patch "fix unbalanced regulator_disable calls, when probe fails"
>    with Fixes to be the first patch of the patchset for easier backporting
>  - don't move pm_runtime_set_active, move devm_add_action_or_reset for
>    inv_mpu_core_disable_regulator_action instead
>  - update commit message in "fix unbalanced regulator_disable calls,
>    when probe fails" to fix Andy's comment
>  - remove blank lines in "use devres-enabled version of pm_runtime_enable"
>  - no dead code in inv_mpu_core_disable_regulator_action anymore since
>    st variable is used to get 'struct device' now
> 
> Changes in v2:
>  - minimize call trace in commit message
>  - use runtime pm framework to track vddio regulator state
>  - include specific driver name in patch subject
>  - add more patches to use device managed functions
> 

