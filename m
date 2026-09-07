Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14D30594E;
	Mon,  7 Sep 2026 01:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788746111; cv=none; b=oQnDdNsxBO/VDOJ80P6AD/xYsA12MYn5OPNFl0mPyYxxrYFVcT4tV5jBAi+dpvh2puZvZFfHkl/8B/6MuOQzskZX5/G3HtbPGE57FLnx7Yd9G7osLWaezUPrBfWeCUuwCapqkZwctsm6SsJwa3mEKOg6hUjzqwwqbZYhHIDGbDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788746111; c=relaxed/simple;
	bh=REHZZpUS00VCfUrJurFT2r0PEuBLbGS4eD8mWy/nr5g=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Y35kiMkf327vnhbbBa3NCmsSEJrPc3XSvmjfVmH9srpNrClc1lxjPwR4T+94tXvT2MAC6z3JIarNbZZdezhy66vCv+nyPXLTc4P4uOc8m3XDoMQRA6yY0LHOn7zte1DmDjEzdLR7791/U1GyFObJ0NeaOWtqnPbZlsv7ODfTmw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NK50UjCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NK50UjCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AA41F00ACF;
	Mon,  7 Sep 2026 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788746109;
	bh=e2nnL6ESJLKVjCo/c5hZWoEYVbP7Y3fsojk2A38uTz4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=NK50UjCuoQ6wEdBumo4RkG7JoBHpfBm795YooPDbe7xqcvY6BEkN/k+dSW874JhKX
	 sWvPoiLH1L6n8tNQfliWsGZ/NMTj/nDbXVSv80eMtBAhnOxbZ40mYDt2gEwC5atJKj
	 k7eXBZx+ztjEEh3KFsHaOsPeXdAsS6j/MeGGNi34BiQPj6BiQGK0qE3L4FAt88h8SH
	 6Lwb33XZ3RIEeb4zuUhbJP+Qm7Y8EvCG1YlRYH78UleVKYRL25Z9I1z6lbsY85t0q0
	 8U7q4o6RFbJ3w5fPJPzhvGxSk7VXHrwXqLgMYAj3Qtm4l6xzLWt2+vXrCY99bJGRM+
	 VRJ7hpVvFfmzA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 8/8] iio: imu: inv_icm42607: Add gyroscope calibbias
 support
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>, 
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260901-b4-inv_icm42370p-v3-8-77cc31642115@axis.com>
References: <20260901-b4-inv_icm42370p-v3-0-77cc31642115@axis.com>
 <20260901-b4-inv_icm42370p-v3-8-77cc31642115@axis.com>
Date: Mon, 07 Sep 2026 02:54:51 +0100
Message-Id: <178874609183.3402141.16201490382277694849.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=551;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=REHZZpUS00VCfUrJurFT2r0PEuBLbGS4eD8mWy/nr5g=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnhlvLVNZvILgF02OizqYJNz+Ig6n0VBHAo7BX
 HpKLW1GkFqJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCap4ZbxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiKGkD/0WSyMPV8cBgE8qX8cYSQxgDn4WQpDjmpdNT2NEqujqs5L
 rV0WmabryQ8O0ucbXNhuy8NWpfLzNS/94hi98rdQD3QKIMxB88A+xnler6YZKdoQmoBuL8I5Nnq
 SRnsM47pg1lRqF1HVLbN4zx/GqQzT3PiJetkRcvuNmcJ1LBF0hFGBOGOtUJNqGMSiur2Q7rqP8w
 LyNkEn5BVIzAbiutOX1yS9fFx8Y+4Pi+JBie5jgRzEIQ4hH8kSis4OxFpupQ3mrDKg8hO05MsyJ
 uBDbnjw4MG5V5sovCBHf9nncEV1i8SKOOVplA/UOBD293YKqaRe7UdzaxnKKzr481yEtyL8q1C1
 lDICmPthFJletLzYpMRFjhy7qGCU7h/XPDhN1skLWuGylGnk9h8c/MiqyZJMCAVxaWYcecuvvpI
 fzXibT11SQrV2yXACVSR9ftY+MxxlJYFZCnpwN1buNnTi0hCQHtT9RQECt80KpfA9yvVlQzcjO7
 6RpPW5vIbWNSu1TrfKYeQG19Ww/ZvAdFq2tBso1ZxDvR4bybOpmW7MDaplbAK7QlOBOtYVuqO43
 v1EyX9tkxB2Vr01G2xlA3RRI28qw9sg/zJcn567CG0SowZ54dXsKUFC2/gtznvluLPTIcQFN43S
 499AEcofASRR9e8WrDE5uwH8KUuYpwr9oNW5COA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Expose IIO_CHAN_INFO_CALIBBIAS on the gyroscope channels. The
> registers are stored in MREG1, which can be accessed by the mreg_read
> and mreg_write routines. The calibration bias is written to OFFSET_USER0
> to OFFSET_USER3 registers in MREG1.
> 
> Note: The gyroscope calibbias functionality is not tested on actual
> hardware.
Drop this one. You don't need it for your part. If anyone else wants
this for the gyroscope then they can propose the design + test it!

Jonatha

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
