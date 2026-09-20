Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2C1F3B8A;
	Sun, 20 Sep 2026 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789870691; cv=none; b=H5OOtlRRa+Ir+1KUjHZd+KU7Gql1K1gw32zNmtWFSToO4r3r601oLatXKYDoma3a2rcL/kG/mmmFR6XysBradKfVx5cJsVu1GwIFRje6Hq/EPQ8WuS2gHnzcwEx9hE+AHvDKSuyWQm6o0l7cmFaLFi6T9j39TuCqoASkbOHCt9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789870691; c=relaxed/simple;
	bh=oo78RpNfiXwJn7r46jiNKS6yIJyDb+MQNVxkmov69Wc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NQyrx+dRj4ztaIMIRHUzwBRwMqinPUaDisYtOYVwW1zJiDT6O2LktlwaCTy9iyDLEOINdSVIosS310j1nSJTspcLK8UoFbtblnAc9ojCOx5NL36eZbxSe+zddF8tffNFN3NlIyH+VI9mThksX2xvm9WMUx/uli5hGpspDj/NHHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfVFWnZ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfVFWnZ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796591F000FF;
	Sun, 20 Sep 2026 02:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789870689;
	bh=1a/vwBnGGSIRYfx7PP1aJOZeFIh+KqK6KRk7beFBFRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MfVFWnZ+ghJ3Yl9mgB9jziDDPYAcV2tY1OJX+/JicFP+ZvlHBKDI4pfV9o4BMBlmF
	 WhkF08o1/sXYWBxN56mOnwA+AF26zinknmaFCvjf8Zwqsl9+XZwwHd+3/ymhJ6kmi/
	 zJrSFNKdWCmCMHzI4bwQ5gi3dxKDdx4EjaJfy7YOpD0LcZOovFK3IjTcIssfBOej83
	 709qjKzSIABKEUo9aLqZqdzWGj3RzZcNwLYiuLtyYr5SoIbgNvuF15nfrHnSEc96wu
	 6mXAZmjydQo7jZ56+f3OIJbxl4cLVU8Iv6zlo/SZV9orVkTp5XLf59I4d/+PFp2nhB
	 DiGQw6GNKyirA==
Date: Sun, 20 Sep 2026 03:18:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org,
 rdunlap@infradead.org, joshua.crofts1@gmail.com,
 u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v10 8/8] iio: osf: add IIO KUnit tests
Message-ID: <20260920031805.1d5aa396@jic23-hlaptop>
In-Reply-To: <59251baa5b1f53a72ac7a09afc334398e2e84db7.1789753020.git.kimjinseob88@gmail.com>
References: <cover.1789753020.git.kimjinseob88@gmail.com>
	<59251baa5b1f53a72ac7a09afc334398e2e84db7.1789753020.git.kimjinseob88@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 03:24:46 +0900
Jinseob Kim <kimjinseob88@gmail.com> wrote:

> Add the existing IIO active-scan packing and buffer producer lifetime
> tests. Extend the test build wiring and help text to cover both suites.
> 
> This changes no production source. The complete series retains the
> production behavior of the combined-driver revision, with CRC
> terminology clarified.
> 
> Assisted-by: LLM
> Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>

So there are a number of generic tests in here (using osf as a device)
that we should probably be looking to pull out as independent self tests
if we can.  Good to have them as something to build on though and
there are of course some driver interactions that matter.

Anyhow, I'd like input from others on how they think we should ensure
the coverage you have here is present but avoid duplication on a per
driver basis (assuming others decide to also start putting together
comprehensive self tests like you have done!).

I'd like to find time to take a close look at these tests but
it won't happen for a while as there is simply to much activity on
the list + I'm travelling in the next few weeks (including Linux
Plumbers in Prague in early October).  So it may be that we end
up merging the driver ahead of these tests.

Jonathan

> ---
>  drivers/iio/opensensorfusion/Kconfig        |   2 +-
>  drivers/iio/opensensorfusion/Makefile       |   2 +-
>  drivers/iio/opensensorfusion/osf_iio_test.c | 325 ++++++++++++++++++++
>  3 files changed, 327 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iio/opensensorfusion/osf_iio_test.c
> 
> diff --git a/drivers/iio/opensensorfusion/Kconfig b/drivers/iio/opensensorfusion/Kconfig
> index 316f33be1327..b4a2cde9645e 100644
> --- a/drivers/iio/opensensorfusion/Kconfig
> +++ b/drivers/iio/opensensorfusion/Kconfig
> @@ -20,7 +20,7 @@ config OPEN_SENSOR_FUSION_KUNIT_TEST
>  	default KUNIT_ALL_TESTS
>  	help
>  	  Build focused unit tests for the Open Sensor Fusion core sample
> -	  acceptance, direct-read cache, and capability/session handling. The tests
> +	  acceptance, direct-read cache, and IIO buffer paths. The tests
>  	  exercise accepted, ignored, and rejected sample handling without
>  	  exposing additional production interfaces.
>  
> diff --git a/drivers/iio/opensensorfusion/Makefile b/drivers/iio/opensensorfusion/Makefile
> index c2f5ba065a62..6a28b14cae1f 100644
> --- a/drivers/iio/opensensorfusion/Makefile
> +++ b/drivers/iio/opensensorfusion/Makefile
> @@ -4,4 +4,4 @@ obj-$(CONFIG_OPEN_SENSOR_FUSION) += open-sensor-fusion.o
>  
>  open-sensor-fusion-y := osf_core.o osf_iio.o osf_protocol.o osf_serdev.o \
>  			 osf_stream.o
> -open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o
> +open-sensor-fusion-$(CONFIG_OPEN_SENSOR_FUSION_KUNIT_TEST) += osf_core_test.o osf_iio_test.o
> diff --git a/drivers/iio/opensensorfusion/osf_iio_test.c b/drivers/iio/opensensorfusion/osf_iio_test.c
> new file mode 100644
> index 000000000000..63d3ca1af329
> --- /dev/null
> +++ b/drivers/iio/opensensorfusion/osf_iio_test.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <kunit/device.h>
> +#include <kunit/test.h>
> +
> +#include <linux/bitmap.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/buffer_impl.h>
> +#include <linux/iio/iio.h>
> +#include <linux/kthread.h>
> +#include <linux/string.h>
> +
> +#include "osf_core.h"
> +#include "osf_iio.h"
> +
> +static noinline void osf_test_poison_stack(void)
> +{
> +	u8 bytes[1024];
> +
> +	memset(bytes, 0xa5, sizeof(bytes));
> +	barrier_data(bytes);
> +}
> +
> +static void osf_iio_check_scan(struct kunit *test, struct iio_dev *indio_dev,
> +			       const s32 *values, unsigned int channels,
> +			       unsigned int mask, bool ts)
> +{
> +	struct iio_buffer *buffer = indio_dev->buffer;
> +	unsigned int data_bytes = hweight32(mask) * sizeof(s32);
> +	unsigned int ts_offset = ALIGN(data_bytes, 8);
> +	unsigned int scan_bytes = ts ? ts_offset + 8 : data_bytes;
> +	unsigned int offset = 0;
> +	u8 scan[24] __aligned(8);
> +	s64 before, after, timestamp;
> +	int ret;
> +
> +	bitmap_zero((unsigned long *)buffer->scan_mask, iio_get_masklength(indio_dev));
> +	for (unsigned int i = 0; i < channels; i++)
> +		if (mask & BIT(i))
> +			set_bit(i, (unsigned long *)buffer->scan_mask);
> +	buffer->scan_timestamp = ts;
> +	ret = iio_update_buffers(indio_dev, buffer, NULL);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	kunit_info(test, "device=%s mask=%u ts=%u bytes=%u\n",
> +		   indio_dev->name, mask, ts, scan_bytes);
> +	memset(scan, 0xa5, sizeof(scan));
> +	before = iio_get_time_ns(indio_dev);
> +	osf_test_poison_stack();
> +	ret = osf_iio_push_sample(indio_dev, values, channels);
> +	after = iio_get_time_ns(indio_dev);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_EQ(test, buffer->bytes_per_datum, scan_bytes);
> +	ret = iio_pop_from_buffer(buffer, scan);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	if (ret)
> +		goto disable;
> +
> +	for (unsigned int i = 0; i < channels; i++) {
> +		if (!(mask & BIT(i)))
> +			continue;
> +		KUNIT_EXPECT_MEMEQ(test, scan + offset, &values[i], sizeof(s32));
> +		offset += sizeof(s32);
> +	}
> +	if (ts) {
> +		for (unsigned int i = data_bytes; i < ts_offset; i++)
> +			KUNIT_EXPECT_EQ(test, scan[i], (u8)0);
> +		memcpy(&timestamp, scan + ts_offset, sizeof(timestamp));
> +		KUNIT_EXPECT_GE(test, timestamp, before);
> +		KUNIT_EXPECT_LE(test, timestamp, after);
> +	}
> +	/* Neither kfifo nor the producer may write outside the consumer stride. */
> +	for (unsigned int i = scan_bytes; i < sizeof(scan); i++)
> +		KUNIT_EXPECT_EQ(test, scan[i], (u8)0xa5);
> +
> +disable:
> +	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), 0);
> +}
> +
> +/* Protect timestamp alignment holes and every supported scan layout. */
> +static void osf_iio_scan_bytes_test(struct kunit *test)
> +{
> +	static const u16 types[] = {
> +		OSF_SENSOR_ACCELEROMETER, OSF_SENSOR_GYROSCOPE,
> +		OSF_SENSOR_MAGNETOMETER, OSF_SENSOR_TEMPERATURE,
> +	};
> +	const s32 values[] = { 101, -202, 303 };
> +	struct osf_capability_entry entry = {
> +		.sample_format = OSF_SAMPLE_FORMAT_S32,
> +		.scale_nano = 1000000,
> +	};
> +	struct osf_device *osf;
> +	struct device *dev;
> +
> +	dev = kunit_device_register(test, "osf-iio");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, osf);
> +	osf_core_init(osf, dev);
> +
> +	for (unsigned int t = 0; t < ARRAY_SIZE(types); t++) {
> +		unsigned int channels = t == 3 ? 1 : 3;
> +		struct iio_dev *indio_dev;
> +		int ret;
> +
> +		entry.sensor_type = types[t];
> +		entry.channel_count = channels;
> +		ret = osf_iio_register_sensor(dev, &entry, osf, &indio_dev);
> +		KUNIT_ASSERT_EQ(test, ret, 0);
> +		for (unsigned int mask = 1; mask < BIT(channels); mask++)
> +			for (unsigned int ts = 0; ts < 2; ts++)
> +				osf_iio_check_scan(test, indio_dev, values, channels, mask, ts);
> +		osf_iio_unregister_sensor(indio_dev);
> +	}
> +}
> +
> +struct osf_iio_race {
> +	struct iio_buffer_access_funcs access;
> +	const struct iio_buffer_access_funcs *original;
> +	struct iio_dev *indio_dev;
> +	struct completion entered;
> +	struct completion release;
> +	struct completion config_started;
> +	struct completion config_done;
> +	atomic_t block_store;
> +	atomic_t stores;
> +	atomic_t disabled;
> +	atomic_t bad_store;
> +	int enable_error;
> +	int disable_error;
> +	int config_result;
> +	bool unregister;
> +};
> +
> +static struct osf_iio_race *osf_iio_race_from_buffer(struct iio_buffer *buffer)
> +{
> +	return container_of(buffer->access, struct osf_iio_race, access);
> +}
> +
> +static int osf_iio_test_store(struct iio_buffer *buffer, const void *data)
> +{
> +	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
> +
> +	if (atomic_xchg(&race->block_store, 0)) {
> +		complete(&race->entered);
> +		if (!wait_for_completion_timeout(&race->release, 5 * HZ))
> +			return -ETIMEDOUT;
> +	}
> +	if (atomic_read(&race->disabled))
> +		atomic_inc(&race->bad_store);
> +	atomic_inc(&race->stores);
> +	return race->original->store_to(buffer, data);
> +}
> +
> +static int osf_iio_test_enable(struct iio_buffer *buffer, struct iio_dev *indio_dev)
> +{
> +	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
> +
> +	if (race->enable_error)
> +		return race->enable_error;
> +	atomic_set(&race->disabled, 0);
> +	return 0;
> +}
> +
> +static int osf_iio_test_disable(struct iio_buffer *buffer, struct iio_dev *indio_dev)
> +{
> +	struct osf_iio_race *race = osf_iio_race_from_buffer(buffer);
> +
> +	atomic_set(&race->disabled, 1);
> +	return race->disable_error;
> +}
> +
> +static int osf_iio_test_producer(void *data)
> +{
> +	struct osf_iio_race *race = data;
> +	const s32 values[] = { 101, -202, 303 };
> +
> +	while (!kthread_should_stop()) {
> +		osf_iio_push_sample(race->indio_dev, values, ARRAY_SIZE(values));
> +		cond_resched();
> +	}
> +	return 0;
> +}
> +
> +static int osf_iio_test_configure(void *data)
> +{
> +	struct osf_iio_race *race = data;
> +
> +	complete(&race->config_started);
> +	if (race->unregister) {
> +		osf_iio_unregister_sensor(race->indio_dev);
> +		race->config_result = 0;
> +	} else {
> +		race->config_result = iio_update_buffers(race->indio_dev, NULL,
> +							 race->indio_dev->buffer);
> +	}
> +	complete(&race->config_done);
> +	while (!kthread_should_stop())
> +		msleep(20);
> +	return 0;
> +}
> +
> +static void osf_iio_expect_quiesce(struct kunit *test, struct osf_iio_race *race)
> +{
> +	struct task_struct *config;
> +	unsigned long waited;
> +
> +	config = kthread_run(osf_iio_test_configure, race, "osf-cfg-test");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, config);
> +	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->config_started, HZ), 0UL);
> +	waited = wait_for_completion_timeout(&race->config_done, msecs_to_jiffies(20));
> +	KUNIT_EXPECT_EQ(test, waited, 0UL);
> +	complete(&race->release);
> +	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->config_done, HZ), 0UL);
> +	kthread_stop(config);
> +	KUNIT_EXPECT_EQ(test, race->config_result, 0);
> +}
> +
> +/* Run real IIO configuration and kfifo code against an independent producer. */
> +static void osf_iio_buffer_lifetime_test(struct kunit *test)
> +{
> +	struct osf_capability_entry entry = {
> +		.sensor_type = OSF_SENSOR_ACCELEROMETER,
> +		.channel_count = 3,
> +		.sample_format = OSF_SAMPLE_FORMAT_S32,
> +		.scale_nano = 1000000,
> +	};
> +	const s32 values[] = { 101, -202, 303 };
> +	struct task_struct *producer;
> +	struct osf_iio_race *race;
> +	struct osf_device *osf;
> +	struct iio_dev *indio_dev;
> +	struct iio_buffer *buffer;
> +	struct device *dev;
> +	int stores, ret;
> +
> +	dev = kunit_device_register(test, "osf-race");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
> +	osf = kunit_kzalloc(test, sizeof(*osf), GFP_KERNEL);
> +	race = kunit_kzalloc(test, sizeof(*race), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, osf);
> +	KUNIT_ASSERT_NOT_NULL(test, race);
> +	osf_core_init(osf, dev);
> +	ret = osf_iio_register_sensor(dev, &entry, osf, &indio_dev);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +	buffer = indio_dev->buffer;
> +	race->indio_dev = indio_dev;
> +	race->original = buffer->access;
> +	race->access = *buffer->access;
> +	race->access.store_to = osf_iio_test_store;
> +	race->access.enable = osf_iio_test_enable;
> +	race->access.disable = osf_iio_test_disable;
> +	buffer->access = &race->access;
> +	init_completion(&race->entered);
> +	init_completion(&race->release);
> +	init_completion(&race->config_started);
> +	init_completion(&race->config_done);
> +	atomic_set(&race->disabled, 1);
> +	set_bit(0, (unsigned long *)buffer->scan_mask);
> +	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
> +
> +	atomic_set(&race->block_store, 1);
> +	producer = kthread_run(osf_iio_test_producer, race, "osf-rx-test");
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, producer);
> +	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
> +	osf_iio_expect_quiesce(test, race);
> +
> +	for (unsigned int i = 0; i < 100; i++) {
> +		bitmap_zero((unsigned long *)buffer->scan_mask, iio_get_masklength(indio_dev));
> +		*(unsigned long *)buffer->scan_mask = (i % 7) + 1;
> +		buffer->scan_timestamp = i & 1;
> +		KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
> +		cond_resched();
> +		KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), 0);
> +	}
> +
> +	race->enable_error = -EIO;
> +	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), -EIO);
> +	stores = atomic_read(&race->stores);
> +	KUNIT_EXPECT_EQ(test, osf_iio_push_sample(indio_dev, values, 3), 0);
> +	KUNIT_EXPECT_EQ(test, atomic_read(&race->stores), stores);
> +	race->enable_error = 0;
> +	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
> +	race->disable_error = -EIO;
> +	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, NULL, buffer), -EIO);
> +	stores = atomic_read(&race->stores);
> +	KUNIT_EXPECT_EQ(test, osf_iio_push_sample(indio_dev, values, 3), 0);
> +	KUNIT_EXPECT_EQ(test, atomic_read(&race->stores), stores);
> +	race->disable_error = 0;
> +
> +	KUNIT_EXPECT_EQ(test, iio_update_buffers(indio_dev, buffer, NULL), 0);
> +	/* Retain ownership while testing unregister against an admitted push. */
> +	get_device(&indio_dev->dev);
> +	reinit_completion(&race->entered);
> +	reinit_completion(&race->release);
> +	reinit_completion(&race->config_started);
> +	reinit_completion(&race->config_done);
> +	atomic_set(&race->block_store, 1);
> +	KUNIT_EXPECT_NE(test, wait_for_completion_timeout(&race->entered, HZ), 0UL);
> +	race->unregister = true;
> +	osf_iio_expect_quiesce(test, race);
> +	kthread_stop(producer);
> +	KUNIT_EXPECT_EQ(test, atomic_read(&race->bad_store), 0);
> +	KUNIT_EXPECT_GT(test, atomic_read(&race->stores), 0);
> +	buffer->access = race->original;
> +	put_device(&indio_dev->dev);
> +}
> +
> +static struct kunit_case osf_iio_test_cases[] = {
> +	KUNIT_CASE(osf_iio_scan_bytes_test),
> +	KUNIT_CASE(osf_iio_buffer_lifetime_test),
> +	{ }
> +};
> +
> +static struct kunit_suite osf_iio_test_suite = {
> +	.name = "osf-iio",
> +	.test_cases = osf_iio_test_cases,
> +};
> +
> +kunit_test_suite(osf_iio_test_suite);
> +
> +MODULE_LICENSE("GPL");

