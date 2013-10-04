Return-Path: <lars@metafoo.de>
Message-ID: <524E7E7D.9020204@metafoo.de>
Date: Fri, 04 Oct 2013 10:38:21 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/18] iio: Extend the event config interface
References: <1380200317-19355-1-git-send-email-lars@metafoo.de> <52487515.7080601@kernel.org> <524877DF.8050005@metafoo.de> <52488AF4.1030802@kernel.org>
In-Reply-To: <52488AF4.1030802@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 09/29/2013 10:17 PM, Jonathan Cameron wrote:
> On 09/29/13 19:56, Lars-Peter Clausen wrote:
>> I think a transparent union should work nicely and doesn't cause any code
>> churn. Maybe even with a direct pointer to the event_spec.
>>
>> Something like:
>>
>> struct iio_dev_attr {
>> 	...
>> 	union {
>> 		u64 address;
>> 		struct {
>> 			struct iio_event_spec *spec;
>> 			enum iio_event_info info;
>> 		} event;
>> 	};
>> 	...
>> };
> Looks good to me.

There is a bug[1] in gcc < 4.6 that breaks this for static struct
initializers. E.g.

static struct iio_dev_attr attr = {
	...
	.address = 123,
	...
};

wont work. So I guess this means we can't use it for now.

- Lars

[1] http://gcc.gnu.org/bugzilla/show_bug.cgi?id=10676
