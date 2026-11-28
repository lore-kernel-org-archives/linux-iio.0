Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795830644;
	b=QbW2VWoBUffwRjWpvUH4jCC40Fnf/A58VAYZyVWXkNLnovzc0GRr6VuGJbcbCmtMyZjr
	 gkUq12bJLO1q9tnzX5GEbMBZw/qccXTnuBytnz+BwZXSSfqOuOtlBnZmuLc3LICvMNlZW
	 9p3kAgBcQkbGb5kJGNxmGn7cbFu60UtQVr8umz3XadsPA/9RumrSOiv2RzHn/iuR6gftr
	 ccrw+gCrGZNyQONm5UY1oSqwuy6oTY/DabNdoxysXy7aYup5sM1z/cstzHxHNp353kHkq
	 0yAb+mzZcOr586jrpJOKjVTAwOCKXVXvYasoqYwVG4IYfl5XQtqpOur6hcm3HN0VwdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795830644;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=vsrlU8gTA5At2h2P01DoL6ti6obAsrLnq9WXk3/lQiw=;
	b=gJRi4NX+bUexrzLBNT7gIbks9qeOpy3ii0MG3bUqnHGrek0BoYhYEv1kGGXoZg4PYaDE
	 GASxUxO1e0sihTidMx763JRiggFpM3VhG3gA4yHng879RQodeYL4uImJHvQqGtshPhYt9
	 /H31YfqUdwJx+XeRTZuEhEFvdwJLIvY3VcVETwCioo6/STikRQjJYDYw/DtrnKWRZ1zd0
	 /AV2DoaGkkhIferxSU6g0GOin2OE9/alWls2nAhtUULu+45MnqRCOAaCmYx/fEjLaR6+r
	 iArwxJUbmOBbKIXNQZbbgxwVAPAgPOALreLpsSHynC3mT/Qe3vn7yrauzny9E+tLjYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmfEUCX7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2A2606A31C
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KmfEUCX7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AD61F000C1;
	Sat, 28 Nov 2026 01:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795830643;
	bh=vsrlU8gTA5At2h2P01DoL6ti6obAsrLnq9WXk3/lQiw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KmfEUCX7zx9SncTVVCbirBHCrQvSu/WMKZBdZZuCGrNXnJUO4tmWlq/bGmFEW6OtA
	 9tevCSPt/el4aRngOil/uX3QTJFKkUG6C9kEQARtAsnNL/NJ8Esv8kcAIcSi4usX70
	 QE25AhuUMVh+LecPVpk+O8zhzSisPj7I+idI2h/69tDdLstYbiG8UuhujJ1LZfg5pB
	 ldNcpZ466SBj4BVV3v+K9OgmR4vhlcc6H1mNQsTXYEV+aTprKYzCBDhCKj2e7AgVQX
	 O8T5ojMTneP4yiyNc9oN1oHIIaw/sONWR4Wrl9z3od0FoT6aI/rupZ1RAbnq8gJcew
	 Vwl1lvjbcnn9A==
Date: Sat, 28 Nov 2026 01:50:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: He Xin <hexin@hexin.host>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 00/18] iio: accel: add mount-matrix support to the
 remaining accelerometer drivers
Message-ID: <20261128015038.776c6c54@jic23-hlaptop>
In-Reply-To: <5F08289E852625FC+20261127030810.3150676-1-hexin@hexin.host>
References: <5F08289E852625FC+20261127030810.3150676-1-hexin@hexin.host>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 11:07:52 +0800
He Xin <hexin@hexin.host> wrote:

> The accelerometer drivers in the tree are inconsistent about honouring the
> installation orientation described by the firmware.  Drivers such as kxcjk-1013,
> mma8452, bmc150 or st_lis3dh read the "mount-matrix" property (ACPI _DSD on
> x86/ACPI platforms, devicetree otherwise) and expose it as
> in_accel_mount_matrix, while the drivers patched here silently ignore it.
I looked at first couple of these. Sashiko caught same stuff I did so:
https://sashiko.dev/#/patchset/AB3626537FF1BFE3%2B20261127030810.3150676-2-hexin%40hexin.host
Make sure you understand the feedback on dma safe buffers for v2.

Thanks,

Jonathan
