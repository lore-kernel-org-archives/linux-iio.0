Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEC83D47B9;
	Thu, 11 Jun 2026 10:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781175589; cv=none; b=tNhvV38sDUZqU4QKfhSWp+oeRUNvAv2Z0465ppS33SCkd0G5iNCJk4TZkdkPuuuQnZEMFEdkVOoS3Ljr+OvLtpH7CUIpwXeFmEr+OdOqRfIUbtvP3/ITrfbmLWB+5DbNWJr3OX4QAHBd+YRFYsIf2+IHSVZhtJvWNsQF0GcNMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781175589; c=relaxed/simple;
	bh=mYy8SrYNX0hSFw6iIYsujkPIlY8TTwbQVZPbmBDyeDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fJHY/qvXO5ZcWuO0X7XT4oNLy+sGA0y5+q86i4LAEFa+upyX7I+SWrwBRCrdAF+Gi4k2E9tjwmv/yvOStF31hT4xJT2sag9Z2adff/g0WZcNs3QcEWIurH/tIOvCvEuVJ5b6GZ4ANjFYxdY8SGt5lTcviLHlpc/cEN+E1jRGYl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN9qenms; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN9qenms"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F5D1F00893;
	Thu, 11 Jun 2026 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781175588;
	bh=mwc9Bper1UY3wwxKaGEuMDkCvCSrvItL4irShhMuQTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KN9qenmsuPwMXwQfUUz3bpy75Su8+LsxupaoigatkiJaj/S8yBaj0EAscJUrgknNp
	 gAPDITk26Fp+DqbxFhGGPQwcrx29gCas7KyWKg3W304WTbk2YRPRB/khx2IiRSBbqN
	 v2NRDFSRFHgPZ0/KD0BDBB16RameHh+ugeIPRbefmMTANPkBSTi/oUVhWIPrrVfXXO
	 Ji50kZLC8UCd3t2Ug9fRCSxlF69+Q26mzWEgckFhE42fH5wxXyjuH2hYnPklV9O3U+
	 FyxZmoXChu9WilhqwnC90BMi+7sr+eQ316z800ETMxogtMFQmKa8dz+eYp9m5ofg6h
	 pkMmLQ0HhlJGw==
Date: Thu, 11 Jun 2026 11:59:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 0/9] Add Invensense ICM42607
Message-ID: <20260611115938.27712b66@jic23-huawei>
In-Reply-To: <20260610175455.19006-1-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 12:54:44 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for the ICM42607 IMU. This sensor shares the same
> functionality but a different register layout with the existing
> ICM42600.
> 
> This driver should work with the ICM42607 and ICM42607P over both I2C
> and SPI, however only the ICM42607P over I2C could be tested.
Hi Chris,

Just a quick reminder to check if there is useful feedback at:
https://sashiko.dev/#/patchset/20260610175455.19006-1-macroalpha82%40gmail.com

I didn't look into most of the but the last one about no avail mask bits
being set for gyro channels was easy to verify as correct and suggests
a testing gap.

Jonathan

