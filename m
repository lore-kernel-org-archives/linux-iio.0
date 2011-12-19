Return-Path: <jic23@hermes.cam.ac.uk>
Date: 19 Dec 2011 08:54:58 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: "J.I. Cameron" <jic23@cam.ac.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
    "Hennerich, Michael" <Michael.Hennerich@analog.com>,
    "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
    "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>,
    Drivers <Drivers@analog.com>
Subject: Re: [PATCH 3/4] staging:iio:events: Use waitqueue lock to protect event
 queue
Message-ID: <Prayer.1.3.4.1112190854580.10234@hermes-2.csi.cam.ac.uk>
In-Reply-To: <Prayer.1.3.4.1112190831070.10234@hermes-2.csi.cam.ac.uk>
References: <1324055542-31272-1-git-send-email-lars@metafoo.de>
 <1324055542-31272-3-git-send-email-lars@metafoo.de>
 <4EEE6114.7090106@kernel.org>
 <4EEEF4DC.8070203@metafoo.de>
 <Prayer.1.3.4.1112190831070.10234@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On Dec 19 2011, J.I. Cameron wrote:

>On Dec 19 2011, Lars-Peter Clausen wrote:
>
>>On 12/18/2011 10:54 PM, Jonathan Cameron wrote:
>>> On 12/16/2011 05:12 PM, Lars-Peter Clausen wrote:
>>>> Use the waitqueue lock to protect the event queue instead of a custom =
mutex.
>>>> This has the advantage that we can call the waitqueue operations with =
the lock
>>>> held, which simplifies the code flow a bit.
>>> Didn't realise this was an option. I'm not finding all that many places
>>> doing this.  Could you point out some examples to compare with?
>>
>>fs/timerfd.c and also see commit 22c43c81a51
>>("wait_event_interruptible_locked() interface")
>Looks 'by the book' so fine with me (and Greg signed off
>on that patch so it should catch him by suprise!)
should not...
>>
>>>>
>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>Acked-by: Jonathan Cameron <jic23@kernel.org>
>>>> ---
>>>>  drivers/staging/iio/industrialio-event.c |   43 ++++++++++++---------=
--------
>>>>  1 files changed, 18 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/iio/industrialio-event.c b/drivers/stagin=
g/iio/industrialio-event.c
>>>> index 50d03bd..ef4943a 100644
>>>> --- a/drivers/staging/iio/industrialio-event.c
>>>> +++ b/drivers/staging/iio/industrialio-event.c
>>>> @@ -34,7 +34,6 @@
>>>>   */
>>>>  struct iio_event_interface {
>>>>  =09wait_queue_head_t=09=09=09wait;
>>>> -=09struct mutex=09=09=09=09event_list_lock;
>>>>  =09DECLARE_KFIFO(det_events, struct iio_event_data, 16);
>>>> =20
>>>>  =09struct list_head dev_attr_list;
>>>> @@ -49,19 +48,17 @@ int iio_push_event(struct iio_dev *indio_dev, u64 =
ev_code, s64 timestamp)
>>>>  =09int ret =3D 0;
>>>> =20
>>>>  =09/* Does anyone care? */
>>>> -=09mutex_lock(&ev_int->event_list_lock);
>>>> +=09spin_lock(&ev_int->wait.lock);
>>>>  =09if (test_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>>>> =20
>>>>  =09=09ev.id =3D ev_code;
>>>>  =09=09ev.timestamp =3D timestamp;
>>>> =20
>>>>  =09=09ret =3D kfifo_put(&ev_int->det_events, &ev);
>>>> -
>>>> -=09=09mutex_unlock(&ev_int->event_list_lock);
>>>>  =09=09if (ret !=3D 0)
>>>> -=09=09=09wake_up_interruptible(&ev_int->wait);
>>>> -=09} else
>>>> -=09=09mutex_unlock(&ev_int->event_list_lock);
>>>> +=09=09=09wake_up_locked(&ev_int->wait);
>>>> +=09}
>>>> +=09spin_unlock(&ev_int->wait.lock);
>>>> =20
>>>>  =09return ret;
>>>>  }
>>>> @@ -79,28 +76,25 @@ static ssize_t iio_event_chrdev_read(struct file *=
filep,
>>>>  =09if (count < sizeof(struct iio_event_data))
>>>>  =09=09return -EINVAL;
>>>> =20
>>>> -=09mutex_lock(&ev_int->event_list_lock);
>>>> +=09spin_lock(&ev_int->wait.lock);
>>>>  =09if (kfifo_is_empty(&ev_int->det_events)) {
>>>>  =09=09if (filep->f_flags & O_NONBLOCK) {
>>>>  =09=09=09ret =3D -EAGAIN;
>>>> -=09=09=09goto error_mutex_unlock;
>>>> +=09=09=09goto error_unlock;
>>>>  =09=09}
>>>> -=09=09mutex_unlock(&ev_int->event_list_lock);
>>>>  =09=09/* Blocking on device; waiting for something to be there */
>>>> -=09=09ret =3D wait_event_interruptible(ev_int->wait,
>>>> +=09=09ret =3D wait_event_interruptible_locked(ev_int->wait,
>>>>  =09=09=09=09=09!kfifo_is_empty(&ev_int->det_events));
>>>>  =09=09if (ret)
>>>> -=09=09=09goto error_ret;
>>>> +=09=09=09goto error_unlock;
>>>>  =09=09/* Single access device so no one else can get the data */
>>>> -=09=09mutex_lock(&ev_int->event_list_lock);
>>>>  =09}
>>>> =20
>>>> -=09mutex_unlock(&ev_int->event_list_lock);
>>>>  =09ret =3D kfifo_to_user(&ev_int->det_events, buf, count, &copied);
>>>> =20
>>>> -error_mutex_unlock:
>>>> -=09mutex_unlock(&ev_int->event_list_lock);
>>>> -error_ret:
>>>> +error_unlock:
>>>> +=09spin_unlock(&ev_int->wait.lock);
>>>> +
>>>>  =09return ret ? ret : copied;
>>>>  }
>>>> =20
>>>> @@ -108,10 +102,10 @@ static int iio_event_chrdev_release(struct inode=
 *inode, struct file *filep)
>>>>  {
>>>>  =09struct iio_event_interface *ev_int =3D filep->private_data;
>>>> =20
>>>> -=09mutex_lock(&ev_int->event_list_lock);
>>>> +=09spin_lock(&ev_int->wait.lock);
>>>>  =09clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>>>>  =09kfifo_reset_out(&ev_int->det_events);
>>>> -=09mutex_unlock(&ev_int->event_list_lock);
>>>> +=09spin_unlock(&ev_int->wait.lock);
>>>> =20
>>>>  =09return 0;
>>>>  }
>>>> @@ -131,18 +125,18 @@ int iio_event_getfd(struct iio_dev *indio_dev)
>>>>  =09if (ev_int =3D=3D NULL)
>>>>  =09=09return -ENODEV;
>>>> =20
>>>> -=09mutex_lock(&ev_int->event_list_lock);
>>>> +=09spin_lock(&ev_int->wait.lock);
>>>>  =09if (test_and_set_bit(IIO_BUSY_BIT_POS, &ev_int->flags)) {
>>>> -=09=09mutex_unlock(&ev_int->event_list_lock);
>>>> +=09=09spin_unlock(&ev_int->wait.lock);
>>>>  =09=09return -EBUSY;
>>>>  =09}
>>>> -=09mutex_unlock(&ev_int->event_list_lock);
>>>> +=09spin_unlock(&ev_int->wait.lock);
>>>>  =09fd =3D anon_inode_getfd("iio:event",
>>>>  =09=09=09=09&iio_event_chrdev_fileops, ev_int, O_RDONLY);
>>>>  =09if (fd < 0) {
>>>> -=09=09mutex_lock(&ev_int->event_list_lock);
>>>> +=09=09spin_lock(&ev_int->wait.lock);
>>>>  =09=09clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>>>> -=09=09mutex_unlock(&ev_int->event_list_lock);
>>>> +=09=09spin_unlock(&ev_int->wait.lock);
>>>>  =09}
>>>>  =09return fd;
>>>>  }
>>>> @@ -351,7 +345,6 @@ static bool iio_check_for_dynamic_events(struct ii=
o_dev *indio_dev)
>>>> =20
>>>>  static void iio_setup_ev_int(struct iio_event_interface *ev_int)
>>>>  {
>>>> -=09mutex_init(&ev_int->event_list_lock);
>>>>  =09INIT_KFIFO(ev_int->det_events);
>>>>  =09init_waitqueue_head(&ev_int->wait);
>>>>  }
>>>=20
>>>=20
>>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
