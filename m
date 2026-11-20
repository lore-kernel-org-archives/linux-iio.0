Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197894;
	b=FAFuE+2NPl1M5rtYxrj3ryez7wMho15agfd2B57ThhBgAIg8+Phic38T99JhbAhEuRBr
	 lq1G3YDE7Gx32Bx0StTdZs3boITLWJOlJQ98S/Kt3CAXk0Y+HN22FRhvm/bYC8CXCnJ6p
	 V0tXRadW0aoN2rBN62lsOdT9uup2DbTWYbiTiG1Zok51DkHTBIjcvbsSCiGf5Onw5T/Pm
	 yY9kRRpDUu6yNmjipz0msDyuzZIOd8XbrRfgY/B5FIZnrp/lRXvJDfXsFnx4rlVfCaE3W
	 2j+wUs6BwdChEQjMrZh9WL5P44QDxEdQDR26AJgLhLEmhz/ZRs+mC/JzQq1wjuZvioQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197894;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=QMLztqnULVc9ZlPFv8fZ777zhC27NMjUKNQ5wWG/h7o=;
	b=YoaLi1e52SAePykEIctLzn7P6m2lSic+Y8gUV/RQsi1yIvPK6L7pmjPC4W+m92bTkhRg
	 hfbU5hGQyP+XgBRgW0uk03OE/A6KVYOHMPvAlXsymLAbzUqJCOFw2oWMdayDhdq4h+UgP
	 ilMl7c6aZVbysmNF7L8au28H59km8hI9pIXB5d7x07t5khSSwSDCwSa8Y3KQrlD92jGPz
	 P0A3yimSM3BmFzOH2aK5wWuMSzSU/xpQXWOr3ZURvaE90PNUtcurStX9JDhxBueW6dQs7
	 xaFE3T0FGaL7j3R1uc3gE6yO5r69QVyhSljTISv7TLJLvnYN8utJFnupgoe3sQ+YqwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+TsGpCD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C8060A263E;
	Fri, 20 Nov 2026 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+TsGpCD
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795197894;
	b=yHssccCSwkevWkpwNby3fJFvyPRzeRqtYqmjgHQD4b6HiryJXe0U0mK/3D+M4inqc2Fv
	 UxY8Me+hP67WkS8u9qUlGR4MOySRNEBHeH20hZzrSQiZ1eXLrZ8x2oO3TbmnjjC7q0iay
	 UICDaZxF/3yJErsM8ST/1XQ1dc1zDbny1yjeFg+t2lPEMUFcvVeDo4A7i0OVwphLTiceT
	 Qj2K/zXu6i+eLJoqLCBMmvjBpZU+AB/X1lcyeHtxrpHW8Ev/dVONXae59ejF9hYEv+IJM
	 XiDkMKTDxbG/uVDzl8t4s33OtjjjFrkyF49eKWgpD3T8tcB1Iudtuanxq2M+20TYYcg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795197894;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=QMLztqnULVc9ZlPFv8fZ777zhC27NMjUKNQ5wWG/h7o=;
	b=BhXgytBqu13kHGhrnAjNyIuFyFa1zete1OXQeMDCzmyJ+uqcgR8owiVNohuI/JO53FTi
	 CcDZuLMvSr+J1jKZ7MD48FuR6PoRLEVk5adTbFieGTwQj8LiqdAWu3n0r1g5olK1vK/SC
	 i581aT2Kv4/hqEhm0doIlSKCnoMk9Bf8cWO78VFDjYdlIHTN1zSTH7CD/GYzFNpXLy8aP
	 OrNcTYo7edo9b2D9UJZJGtSCiHhip2acXse/BZjqZqiSgeqbwtrfijSFiOxZkZGW4Ho1s
	 Huv2AkVBjvKEZpAyFam8DfxeOuSdtlvT+iuACYEIOgfxevkr/lQPbG0QPev2exZHuzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 955341F000D2;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795197894;
	bh=QMLztqnULVc9ZlPFv8fZ777zhC27NMjUKNQ5wWG/h7o=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=b+TsGpCD/y2C7URwFwk2nXti2dLFfROwaWd499vBXuJJ0S3GJm0YM7TYaLmPqVAjP
	 mq/XGCKbh53oX/UAc/bIuQJCaLM0X0APFs032UG56XqEeGlgCvcujH6rXqYftJ0bRO
	 nS36g5Qa6p7h4RQIdnE0AorsTcN2P7Ll/yM8TJRBMoMlrI4bcuczz5TnjCsPS+fdP6
	 PYGdQUOega+zpJjrLbbPWd/rZDsp2ALGI/uSK3kZi0xt2FUVr7jt0/xCeFYZdO6a/J
	 FxOnD7wP5pK3SIDIHO5OSR40x/RwKHIrq4Kwbry7wEoL5OJm/Hnd5aVtGFzAx/aVqJ
	 jX/tG/vxO5Zqg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2AC8D4B8A2;
	Fri, 20 Nov 2026 18:04:43 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Subject: [PATCH RFC 0/5] iio: split struct iio_dev_attr into typed core
 attributes
Date: Fri, 20 Nov 2026 18:03:56 +0000
Message-Id: <20261120-iio-core-attr-review-v1-0-05b41f8133c2@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIyLAGsC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyMD3czMfN3k/KJU3cSSkiJdkJbUcl1DYyPjJGNLCxOzNEsloNaCotS
 0zAqwsdFKQW7OSrEQweLSpKzU5BKQgUq1tQAGUDehfQAAAA==
X-Change-ID: 20261120-iio-core-attr-review-1323b39846f9
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795197883; l=4276;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=wA+ikYFGpnl6mFqtqCuP9Q8GUxVhzb7hcI8h1ZCXeoE=;
 b=m3p3oBDIFBQqsHYTDHGNExVkdXn1Et3BudskqbqPPbY1PfR0yh9Bh02KsiiYc4uyBY29o3T3G
 /vZby+C2tVIDTJ8EENlbEyv5nssVcsQHy8nAQqUxl1m386dcmPPk7Uk
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

struct iio_dev_attr does three unrelated jobs: it backs the static
attributes declared by drivers through IIO_DEVICE_ATTR*(), the channel
and event attributes generated by the IIO core, and the per-buffer
attributes. Every user carries every field (l, c, buffer), whether it
needs them or not, and the meaning of @address depends on the context:
an info mask bit, an ext_info index, a scan index or, for events, the
event_spec index and the event info packed together.

This series keeps struct iio_dev_attr as what drivers use (dev_attr and
address) and moves the core-only state into private types embedding it:

  struct iio_chan_attr   - core channel attributes (channel, list node)
  struct iio_event_attr  - extends it with the event spec
  struct iio_buffer_attr - extends it with the owning buffer

Attribute creation is split into iio_chan_attr_prepare(), which builds
the full name and runs the duplicate check, and iio_chan_attr_add(),
which initializes an attribute allocated by the caller. Each context
allocates its own type and sets its own fields, so the core needs no
size, offset or context pointer.

The intended benefits are:

- Static driver attributes no longer carry the core-only fields: 32
  bytes less per IIO_DEVICE_ATTR*() on 64-bit (72 -> 40, without
  lockdep), for roughly 220 users in tree.

- Core channel attributes fit a smaller slab class: struct iio_chan_attr
  is 64 bytes on 64-bit, where struct iio_dev_attr was 72 (kmalloc-64
  instead of kmalloc-96).

- Shared attributes (info_mask_shared_by_*, shared ext_info and shared
  event info) are deduplicated before anything is allocated. Today,
  every channel after the first one allocates the attribute and its
  name, finds the duplicate and frees both again.

- Event attributes point to their struct iio_event_spec instead of
  packing (info << 16) | spec_index into the address.

- Buffer implementations no longer depend on the attribute layout to
  find their buffer: iio_attr_to_buffer() replaces
  to_iio_dev_attr(attr)->buffer.

- Context-specific attributes become an extension point instead of yet
  another field in a shared structure. The IIO backend framework is the
  obvious next user: iio_backend_ext_info_{get,set}() recover the
  backend from indio_dev->dev.parent, which, as noted there, breaks as
  soon as a frontend has more than one backend, and
  iio_backend_extend_chan_spec() refuses to combine backend ext_info with
  the frontend's own. A struct iio_backend_attr carrying its struct
  iio_backend, created through the same prepare/add steps (and so
  deduplicated against the frontend attributes), could address both
  without touching struct iio_dev_attr or struct iio_info. That is not
  part of this series.

No ABI change is intended: attribute names, modes and callbacks are
unchanged.

This series was developed with the help of an AI coding assistant
(Claude Opus 5.5, through Claude Code). Over an interactive session, it
reviewed the IIO core, discussed design alternatives, wrote the code
under my direction and helped write the commit messages. I reviewed all
of it, and the design choices are mine.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
Rodrigo Alencar (5):
      iio: buffer: add iio_attr_to_buffer() helper
      iio: core: add struct iio_chan_attr and split attribute creation
      iio: event: add struct iio_event_attr
      iio: buffer: add struct iio_buffer_attr
      iio: sysfs: drop core-only fields from struct iio_dev_attr

 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   2 +-
 drivers/iio/iio_core.h                             |  58 +++--
 drivers/iio/industrialio-buffer.c                  | 153 +++++++-----
 drivers/iio/industrialio-core.c                    | 278 +++++++++++----------
 drivers/iio/industrialio-event.c                   |  99 ++++++--
 include/linux/iio/buffer_impl.h                    |   3 +
 include/linux/iio/sysfs.h                          |   9 -
 7 files changed, 361 insertions(+), 241 deletions(-)
---
base-commit: c1b99c6982dccade0199879966a2d97f27a0a110
change-id: 20261120-iio-core-attr-review-1323b39846f9

Best regards,
--  
Rodrigo Alencar <rodrigo.alencar@analog.com>


